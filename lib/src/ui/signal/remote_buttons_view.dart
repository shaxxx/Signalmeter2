import 'package:enigma_signal_meter/src/message_provider.dart';
import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/enigma/enigma_command_events.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';

class RemoteButtonsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var store = StoreProvider.of<AppState>(context);
    var messages = MessageProvider.of(context);
    var channelUpDownButtons =
        store.state.globalState.applicationSettings.channelUpDownButtons;
    RemoteControlCode channelDown;
    RemoteControlCode channelUp;
    switch (channelUpDownButtons) {
      case ChannelUpDownButtonsEnum.LeftRightArrows:
        channelDown = RemoteControlCode.left;
        channelUp = RemoteControlCode.right;
        break;
      case ChannelUpDownButtonsEnum.UpDownArrows:
        channelDown = RemoteControlCode.down;
        channelUp = RemoteControlCode.up;
        break;
      default:
        channelDown = RemoteControlCode.bouquetDown;
        channelUp = RemoteControlCode.bouquetUp;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        InkWell(
          child: Padding(
            child: Text(
              messages.channel.toUpperCase() + '-',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: theme.accentColor,
              ),
            ),
            padding: EdgeInsets.all(10),
          ),
          onTap: () => store.dispatch(
            SendRemoteControlCodeEvent(
              profile: store.state.profilesState.selectedProfile,
              code: channelDown,
            ),
          ),
        ),
        InkWell(
          child: Padding(
            child: Text(
              messages.channel.toUpperCase() + '+',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: theme.accentColor),
            ),
            padding: EdgeInsets.all(10),
          ),
          onTap: () => store.dispatch(
            SendRemoteControlCodeEvent(
              profile: store.state.profilesState.selectedProfile,
              code: channelUp,
            ),
          ),
        )
      ],
    );
  }
}
