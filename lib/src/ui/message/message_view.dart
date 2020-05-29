import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/ui/common/scaffold_background.dart';
import 'package:enigma_signal_meter/src/ui/message/message_viewmodel.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../message_provider.dart';

class MessageView extends StatefulWidget {
  @override
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  final _formKey = GlobalKey<FormState>();
  final messageController = TextEditingController();
  final timeoutController = TextEditingController();
  MessageType messageType = MessageType.info;

  _MessageViewState() {
    timeoutController.text = '15';
  }
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ScaffoldBackground(
      backgroundColor: theme.primaryColor.withOpacity(0.3),
      appBar: AppBar(
        title: Text(MessageProvider.of(context).message),
        backgroundColor: theme.primaryColor.withOpacity(0.6),
      ),
      child: StoreConnector<AppState, MessageViewModel>(
        distinct: true,
        converter: (store) {
          return MessageViewModel.fromStore(store);
        },
        builder: (context, viewModel) {
          if (viewModel.status == LoadingStatus.success) {
            messageController.text = '';
          }
          return Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _progressBar(viewModel),
                  Container(
                    padding: EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 20),
                    child: TextFormField(
                      maxLines: 5,
                      autocorrect: false,
                      autofocus: true,
                      controller: messageController,
                      keyboardType: TextInputType.text,
                      cursorRadius: Radius.circular(20),
                      validator: (value) {
                        if (value.isEmpty) {
                          return ' ';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: MessageProvider.of(context).message,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _MessageTypeSelection(
                          messageType,
                          (value) => setState(() => messageType = value),
                        ),
                        Container(
                          width: 100,
                          child: TextFormField(
                            autovalidate: true,
                            textAlign: TextAlign.right,
                            //maxLength: 3,
                            minLines: 1,
                            maxLines: 1,
                            autocorrect: false,
                            controller: timeoutController,
                            keyboardType: TextInputType.number,
                            cursorRadius: Radius.circular(20),
                            validator: (value) {
                              if (value.isEmpty) {
                                return ' ';
                              }
                              return null;
                            },
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              hintText: MessageProvider.of(context).time,
                              labelText: MessageProvider.of(context).time,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, right: 5, left: 5),
                                child: IconButton(
                                  icon: Icon(Icons.send, size: 30),
                                  onPressed: viewModel.status !=
                                          LoadingStatus.loading
                                      ? () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            viewModel.onSendMessage(
                                              messageController.text,
                                              Duration(
                                                  seconds: int.parse(
                                                      timeoutController.text)),
                                              messageType,
                                            );
                                          }
                                        }
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _progressBar(MessageViewModel viewModel) {
    if (viewModel.status == LoadingStatus.loading) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: LinearProgressIndicator(),
      );
    }
    return SizedBox.shrink();
  }
}

class _MessageTypeSelection extends StatelessWidget {
  const _MessageTypeSelection(this.messageType, this.onMessageTypeChanged);
  final ValueChanged<MessageType> onMessageTypeChanged;
  final MessageType messageType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
        constraints: BoxConstraints(minWidth: 150),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            const Radius.circular(10.0),
          ),
          color: Theme.of(context).primaryColor.withOpacity(0.3),
          border: Border.all(color: Theme.of(context).focusColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton(
                value: messageType,
                items: [
                  DropdownMenuItem<MessageType>(
                    value: MessageType.info,
                    child: Text('Info'),
                  ),
                  DropdownMenuItem<MessageType>(
                    value: MessageType.warning,
                    child: Text(MessageProvider.of(context).titleWarning),
                  ),
                  DropdownMenuItem<MessageType>(
                    value: MessageType.message,
                    child: Text(MessageProvider.of(context).titleError),
                  ),
                ],
                onChanged: (MessageType value) {
                  onMessageTypeChanged(value);
                },
              ),
            ),
          ),
        ),
      ),
    );
    // return Container(
    //   padding: EdgeInsets.only(top: 10),
    //   constraints: BoxConstraints(minWidth: 150),
    //   child: DropdownButton<MessageType>(
    //     value: messageType,
    //     items: [
    //       DropdownMenuItem<MessageType>(
    //         value: MessageType.info,
    //         child: Text('Info'),
    //       ),
    //       DropdownMenuItem<MessageType>(
    //         value: MessageType.warning,
    //         child: Text(MessageProvider.of(context).titleWarning),
    //       ),
    //       DropdownMenuItem<MessageType>(
    //         value: MessageType.message,
    //         child: Text(MessageProvider.of(context).titleError),
    //       ),
    //     ],
    //     onChanged: (MessageType value) {
    //       onMessageTypeChanged(value);
    //     },
    //   ),
    // );
  }
}
