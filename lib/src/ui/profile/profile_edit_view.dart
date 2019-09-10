import 'package:enigma_signal_meter/src/message_provider.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/ui/common/scaffold_background.dart';
import 'package:enigma_signal_meter/src/ui/profile/enigma_version_row.dart';
import 'package:enigma_signal_meter/src/ui/profile/profile_widget.dart';
import 'package:enigma_signal_meter/src/ui/profile/usessl_row.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'address_row.dart';
import 'http_port_row.dart';
import 'name_row.dart';
import 'password_row.dart';
import 'profile_edit_viewmodel.dart';
import 'streaming_port_row.dart';
import 'streaming_row.dart';
import 'transcoding_port_row.dart';
import 'transcoding_row.dart';
import 'username_row.dart';

class ProfileEditView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var profile = ModalRoute.of(context).settings.arguments;
    return ScaffoldBackground(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.3),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.6),
        title: profile == null
            ? Text(MessageProvider.of(context).actionAddProfile)
            : Text(MessageProvider.of(context).actionEditProfile),
      ),
      child: StoreConnector<AppState, ProfileEditViewModel>(
        distinct: true,
        converter: (store) => ProfileEditViewModel.fromStore(store),
        builder: (context, viewModel) {
          return SingleChildScrollView(
            child: ProfileWidget(
              viewModel: viewModel,
              profile: profile,
              child: Builder(builder: (context) {
                var profileWidget = ProfileWidget.of(context);
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    NameRow(),
                    AddressRow(),
                    HttpPortRow(),
                    UsernameRow(),
                    PasswordRow(),
                    EnigmaVersionRow(),
                    UseSslRow(),
                    StreamingRow(),
                    profileWidget.profile.streaming &&
                            profileWidget.profile.enigma == EnigmaType.enigma2
                        ? StreamingPortRow()
                        : SizedBox.shrink(),
                    profileWidget.profile.streaming &&
                            profileWidget.profile.enigma == EnigmaType.enigma2
                        ? TranscodingRow()
                        : SizedBox.shrink(),
                    profileWidget.profile.transcoding
                        ? TranscodingPortRow()
                        : SizedBox.shrink(),
                    _saveButton(context, profileWidget),
                    Container(height: 20),
                  ],
                );
              }),
            ),
          );
        },
      ),
    );
  }

  Container _saveButton(
      BuildContext context, ProfileWidgetState profileWidget) {
    return Container(
      padding: EdgeInsets.only(top: 20, right: 20, left: 20),
      alignment: Alignment.center,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0)),
        color: Theme.of(context).primaryColor.withOpacity(0.6),
        onPressed: () async {
          var formValid = await profileWidget.validateForm();
          if (formValid) {
            profileWidget.saveForm();
          }
        },
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(vertical: 15),
          child: Text(
            MessageProvider.of(context).actionSave.toUpperCase(),
            style:
                TextStyle(fontSize: 16, color: Theme.of(context).accentColor),
          ),
        ),
      ),
    );
  }
}
