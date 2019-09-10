import 'package:flutter/widgets.dart';

import '../../message_provider.dart';
import 'padded_form_text_field.dart';
import 'profile_widget.dart';

class UsernameRow extends StatelessWidget {
  const UsernameRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profileWidget = ProfileWidget.of(context);
    return PaddedFormTextField(
      controller: profileWidget.usernameController,
      hintText: MessageProvider.of(context).profileUsernameHint,
      labelText: MessageProvider.of(context).profileUsername,
      validator: profileWidget.usernameValidator,
    );
  }
}
