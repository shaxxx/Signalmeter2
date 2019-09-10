import 'package:enigma_web/enigma_web.dart';
import 'package:flutter/widgets.dart';

/// Wraps all exceptions comming from enigma_web package
/// and includes calling command for extra details.
class EnigmaWebException implements Exception {
  final ICommand command;
  final KnownException innerException;

  EnigmaWebException({
    /// Enigma command that resulted with exception
    @required this.command,

    /// enigma_web package wraps all exceptions with KnownException type.
    @required this.innerException,
  })  : assert(command != null),
        assert(innerException != null);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnigmaWebException &&
          runtimeType == other.runtimeType &&
          command == other.command &&
          innerException == other.innerException;

  @override
  int get hashCode => command.hashCode ^ innerException.hashCode;
}
