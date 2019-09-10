import 'package:enigma_web/enigma_web.dart';
import 'package:flutter/widgets.dart';

import '../../message_provider.dart';
import 'padded_form_text_field.dart';
import 'profile_widget.dart';

class StreamingPortRow extends StatelessWidget {
  const StreamingPortRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profileWidget = ProfileWidget.of(context);
    return PaddedFormTextField(
      controller: profileWidget.streamingPortController,
      hintText: profileWidget.profile.enigma == EnigmaType.enigma2
          ? MessageProvider.of(context).profileStreamingPorthint
          : MessageProvider.of(context).profileStreamingPorthintEnigma1,
      labelText: MessageProvider.of(context).profileStreamingPort,
      validator: profileWidget.streamingPortValidator,
      isNumeric: true,
    );
  }
}
