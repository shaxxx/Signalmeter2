import 'package:flutter/widgets.dart';

import '../../message_provider.dart';
import 'padded_form_text_field.dart';
import 'profile_widget.dart';

class AddressRow extends StatelessWidget {
  const AddressRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profileWidget = ProfileWidget.of(context);
    return PaddedFormTextField(
      controller: profileWidget.addressController,
      hintText: MessageProvider.of(context).profileAddressHint,
      labelText: MessageProvider.of(context).profileAddress,
      validator: profileWidget.addressValidator,
    );
  }
}
