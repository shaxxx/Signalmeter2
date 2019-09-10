import 'package:flutter/widgets.dart';

import '../../message_provider.dart';
import 'padded_form_text_field.dart';
import 'profile_widget.dart';

class NameRow extends StatelessWidget {
  const NameRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profileWidget = ProfileWidget.of(context);
    return PaddedFormTextField(
      controller: profileWidget.nameController,
      hintText: MessageProvider.of(context).profileNameHint,
      labelText: MessageProvider.of(context).profileName,
      validator: profileWidget.nameValidator,
    );
  }
}
