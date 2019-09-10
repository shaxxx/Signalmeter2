import 'package:flutter/widgets.dart';

class TtsException implements Exception {
  final String message;
  final dynamic innerException;
  TtsException({
    @required this.message,
    this.innerException,
  }) : assert(message != null);
}
