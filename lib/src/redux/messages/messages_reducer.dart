import 'package:redux/redux.dart';

import 'error_messages_events.dart';
import 'info_messages_events.dart';
import 'messages_state.dart';
import 'warning_messages_events.dart';

final messagesReducer = combineReducers<MessagesState>([
  TypedReducer<MessagesState, ErrorMessageEvent>(_errorMessageReducer).call,
  TypedReducer<MessagesState, WarningMessageEvent>(_warningMessageReducer).call,
  TypedReducer<MessagesState, InfoMessageEvent>(_infoMessageReducer).call,
  TypedReducer<MessagesState, InfoMessageShownEvent>(_infoMessageShownReducer).call,
  TypedReducer<MessagesState, ErrorMessageShownEvent>(
      _errorMessageShownReducer).call,
  TypedReducer<MessagesState, WarningMessageShownEvent>(
      _warningMessageShownReducer).call,
]);

MessagesState _errorMessageReducer(
    MessagesState state, ErrorMessageEvent event) {
  var errors = <ErrorMessageEvent>[...state.errorMessages];
  errors.add(event);
  return state.copyWith(
    errorMessages: errors,
  );
}

MessagesState _warningMessageReducer(
    MessagesState state, WarningMessageEvent event) {
  var warnings = <WarningMessageEvent>[...state.warningMessages];
  warnings.add(event);
  return state.copyWith(
    warningMessages: warnings,
  );
}

MessagesState _infoMessageReducer(MessagesState state, InfoMessageEvent event) {
  var infos = <InfoMessageEvent>[...state.infoMessages];
  infos.add(event);
  return state.copyWith(
    infoMessages: infos,
  );
}

MessagesState _infoMessageShownReducer(
    MessagesState state, InfoMessageShownEvent event) {
  var infos = <InfoMessageEvent>[...state.infoMessages];
  infos.remove(event.infoMessageEvent);
  return state.copyWith(
    infoMessages: infos,
  );
}

MessagesState _errorMessageShownReducer(
    MessagesState state, ErrorMessageShownEvent event) {
  var errors = <ErrorMessageEvent>[...state.errorMessages];
  errors.remove(event.errorMessageEvent);
  return state.copyWith(
    errorMessages: errors,
  );
}

MessagesState _warningMessageShownReducer(
    MessagesState state, WarningMessageShownEvent event) {
  var warnings = <WarningMessageEvent>[...state.warningMessages];
  warnings.remove(event.warningMessageEvent);
  return state.copyWith(
    warningMessages: warnings,
  );
}
