import 'package:enigma_signal_meter/src/message_provider.dart';
import 'package:enigma_signal_meter/src/model/application_settings.dart';
import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../constants.dart';
import 'settings_viewmodel.dart';

const double _kItemHeight = 48.0;
const EdgeInsetsDirectional _kItemPadding =
    EdgeInsetsDirectional.only(start: 56.0);

class _OptionsItem extends StatelessWidget {
  const _OptionsItem({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.textScaleFactorOf(context);

    return MergeSemantics(
      child: Container(
        constraints: BoxConstraints(minHeight: _kItemHeight * textScaleFactor),
        padding: _kItemPadding,
        alignment: AlignmentDirectional.centerStart,
        child: DefaultTextStyle(
          style: DefaultTextStyle.of(context).style,
          maxLines: 2,
          overflow: TextOverflow.fade,
          child: IconTheme(
            data: Theme.of(context).primaryIconTheme,
            child: child,
          ),
        ),
      ),
    );
  }
}

class _BooleanItem extends StatelessWidget {
  const _BooleanItem(this.title, this.value, this.onChanged, {this.switchKey});

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Key? switchKey;

  @override
  Widget build(BuildContext context) {
    return _OptionsItem(
      child: Row(
        children: <Widget>[
          Expanded(child: Text(title)),
          Switch(
            key: switchKey,
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  const _ActionItem(this.text, this.onTap);

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _OptionsItem(
      child: _FlatButton(
        onPressed: onTap,
        child: Text(text),
      ),
    );
  }
}

class _FlatButton extends StatelessWidget {
  const _FlatButton({this.onPressed, required this.child});

  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: onPressed,
      child: Align(
        alignment: Alignment.centerLeft,
        child: DefaultTextStyle(
          style: Theme.of(context).primaryTextTheme.titleMedium!,
          child: child,
        ),
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _OptionsItem(
      child: DefaultTextStyle(
        style: theme.textTheme.bodyMedium!.copyWith(
          color: theme.colorScheme.secondary,
        ),
        child: Semantics(
          header: true,
          child: Text(text),
        ),
      ),
    );
  }
}

class _DbPrimaryItem extends StatelessWidget {
  const _DbPrimaryItem(this.applicationSettings, this.onSettingsChanged);

  final ApplicationSettings applicationSettings;
  final ValueChanged<ApplicationSettings> onSettingsChanged;

  @override
  Widget build(BuildContext context) {
    return _BooleanItem(
      MessageProvider.of(context).useDbAsPrimaryLevel,
      applicationSettings.dbIsPrimaryLevel,
      (bool value) {
        onSettingsChanged(
          applicationSettings.copyWith(
            dbIsPrimaryLevel: value,
          ),
        );
      },
      switchKey: const Key('dbprimary_item'),
    );
  }
}

class _ChannelUpDownButtons extends StatelessWidget {
  const _ChannelUpDownButtons(this.applicationSettings, this.onSettingsChanged);

  final ApplicationSettings applicationSettings;
  final ValueChanged<ApplicationSettings> onSettingsChanged;

  @override
  Widget build(BuildContext context) {
    return _OptionsItem(
      child: DropdownButton<ChannelUpDownButtonsEnum>(
        value: applicationSettings.channelUpDownButtons,
        items: [
          DropdownMenuItem<ChannelUpDownButtonsEnum>(
            value: ChannelUpDownButtonsEnum.ChannelUpDown,
            child: Text(MessageProvider.of(context).channelUpDown),
          ),
          DropdownMenuItem<ChannelUpDownButtonsEnum>(
            value: ChannelUpDownButtonsEnum.LeftRightArrows,
            child: Text(MessageProvider.of(context).leftRigtArrows),
          ),
          DropdownMenuItem<ChannelUpDownButtonsEnum>(
            value: ChannelUpDownButtonsEnum.UpDownArrows,
            child: Text(MessageProvider.of(context).upDownArrows),
          ),
        ],
        onChanged: (ChannelUpDownButtonsEnum? value) {
          onSettingsChanged(
            applicationSettings.copyWith(
              channelUpDownButtons: value,
            ),
          );
        },
      ),
    );
  }
}

class SettingsView extends StatelessWidget {
  final ValueChanged<ApplicationSettings> onSettingsChanged;

  const SettingsView({
    super.key,
    required this.onSettingsChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var locale = Localizations.localeOf(context);
    var languageCode =
        SignalMeterLocalizationsDelegate.getWebLanguageCode(locale);
    if (languageCode.isNotEmpty) {
      languageCode += '/';
    }
    var url = '$krkadoniUrl/#/${languageCode}using';
    return StoreConnector<AppState, SettingsViewModel>(
        distinct: true,
        converter: (store) {
          return SettingsViewModel.fromStore(store);
        },
        builder: (context, viewModel) {
          return DefaultTextStyle(
            style: theme.primaryTextTheme.titleMedium!,
            child: ListView(
              padding: const EdgeInsets.only(bottom: 124.0, right: 20),
              children: <Widget>[
                _Heading(MessageProvider.of(context).signal),
                _DbPrimaryItem(
                    viewModel.applicationSettings, onSettingsChanged),
                _Heading(MessageProvider.of(context).mapChannelUpDownTo),
                _ChannelUpDownButtons(
                    viewModel.applicationSettings, onSettingsChanged),
                const _Heading('SignalMeter'),
                _ActionItem(
                  MessageProvider.of(context).actionAbout,
                  viewModel.onAbout,
                ),
                _ActionItem(
                  MessageProvider.of(context).informationsSupport,
                  () => viewModel.onSupport(url),
                ),
              ],
            ),
          );
        });
  }
}
