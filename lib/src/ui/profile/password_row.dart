import 'package:flutter/widgets.dart';

import '../../message_provider.dart';
import 'padded_form_text_field.dart';
import 'profile_widget.dart';

class PasswordRow extends StatelessWidget {
  const PasswordRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profileWidget = ProfileWidget.of(context);
    return PaddedFormTextField(
      controller: profileWidget.passwordController,
      hintText: MessageProvider.of(context).profilePasswordHint,
      labelText: MessageProvider.of(context).profilePassword,
      validator: profileWidget.passwordValidator,
      isPassword: true,
    );
  }
}
