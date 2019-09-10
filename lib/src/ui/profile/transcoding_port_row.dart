import 'package:flutter/widgets.dart';

import '../../message_provider.dart';
import 'padded_form_text_field.dart';
import 'profile_widget.dart';

class TranscodingPortRow extends StatelessWidget {
  const TranscodingPortRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profileWidget = ProfileWidget.of(context);
    return PaddedFormTextField(
      controller: profileWidget.transcodingPortController,
      hintText: MessageProvider.of(context).profileTranscodingPortHint,
      labelText: MessageProvider.of(context).profileTranscodingPort,
      validator: profileWidget.transcodingPortValidator,
      isNumeric: true,
    );
  }
}
