import 'package:flutter/widgets.dart';

import '../../message_provider.dart';
import 'padded_form_text_field.dart';
import 'profile_widget.dart';

class HttpPortRow extends StatelessWidget {
  const HttpPortRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profileWidget = ProfileWidget.of(context);
    return PaddedFormTextField(
      controller: profileWidget.httpPortController,
      hintText: MessageProvider.of(context).profilePortHint,
      labelText: MessageProvider.of(context).profilePort,
      validator: profileWidget.httpPortValidator,
      isNumeric: true,
    );
  }
}
