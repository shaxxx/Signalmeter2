// Copyright by Iiro Krankka
// Taken from https://github.com/roughike/inKino
// LICENSE Apache License Version 2.0

import 'package:enigma_signal_meter/src/i18n/messages.dart';
import 'package:flutter/material.dart';


import '../../message_provider.dart';

class ErrorView extends InfoMessageView {
  static const Key tryAgainButtonKey = Key('tryAgainButton');

  const ErrorView({super.key, 
    super.title,
    super.description,
    required VoidCallback onRetry,
  }) : super(
          actionButtonKey: tryAgainButtonKey,
          onActionButtonTapped: onRetry,
        );
}

class InfoMessageView extends StatelessWidget {
  const InfoMessageView({
    super.key,
    this.title,
    required this.description,
    this.actionButtonKey,
    this.onActionButtonTapped,
  });

  final String? title;
  final String? description;
  final Key? actionButtonKey;
  final VoidCallback? onActionButtonTapped;

  List<Widget> _buildContent(Messages messages) => [
        const CircleAvatar(
          backgroundColor: Colors.white12,
          radius: 42.0,
          child: Icon(
            Icons.info_outline,
            color: Colors.white70,
            size: 52.0,
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          title ?? messages.oops,
          style: const TextStyle(fontSize: 24.0, color: Colors.white),
        ),
        const SizedBox(height: 8.0),
        Text(
          description ?? '',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final messages = MessageProvider.of(context);
    final content = _buildContent(messages);

    content.add(_ActionButton(
      actionButtonKey,
      onActionButtonTapped,
    ));

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: content,
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton(Key? key, this.onActionButtonTapped) : super(key: key);
  final VoidCallback? onActionButtonTapped;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: TextButton(
        onPressed: onActionButtonTapped,
        child: Text(
          MessageProvider.of(context).tryAgain,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
