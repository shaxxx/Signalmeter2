import 'package:enigma_signal_meter/src/message_provider.dart';
import 'package:enigma_signal_meter/src/ui/profile/profile_edit_model.dart';
import 'package:enigma_signal_meter/src/ui/profile/profile_edit_viewmodel.dart';
import 'package:enigma_signal_meter/src/utils/network_utils.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:flutter/material.dart';

class _InheritedProfileWidget extends InheritedWidget {
  final ProfileWidgetState data;
  const _InheritedProfileWidget({
    required this.data,
    required super.child,
  });

  @override
  bool updateShouldNotify(_InheritedProfileWidget old) => true;
}

class ProfileWidget extends StatefulWidget {
  final Widget child;
  final IProfile? profile;
  final ProfileEditViewModel viewModel;

  const ProfileWidget(
      {super.key, required this.child, this.profile, required this.viewModel});

  static ProfileWidgetState of(BuildContext context) {
    return (context
            .dependOnInheritedWidgetOfExactType<_InheritedProfileWidget>())!
        .data;
  }

  @override
  ProfileWidgetState createState() => ProfileWidgetState();
}

class ProfileWidgetState extends State<ProfileWidget> {
  ProfileEditModel profile = ProfileEditModel();
  final _formKey = GlobalKey<FormState>();
  FocusScopeNode focusNode = FocusScopeNode();

  @override
  void initState() {
    super.initState();
    final existing = widget.profile;
    if (existing != null) {
      profile = ProfileEditModel.fromProfile(existing as Profile);
    }
    _setTextFieldValues();
    _setListeners();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _setValidators();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    transcodingPortController.dispose();
    streamingPortController.dispose();
    httpPortController.dispose();
    super.dispose();
  }

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final transcodingPortController = TextEditingController();
  final streamingPortController = TextEditingController();
  final httpPortController = TextEditingController();

  late FormFieldValidator<String?> nameValidator;
  late FormFieldValidator<String?> addressValidator;
  late FormFieldValidator<String?> usernameValidator;
  // Password has no validation rule (matches the original pre-null-safety
  // behavior where this field defaulted to null). Kept nullable rather than
  // `late` so PasswordRow can pass it through as a null validator.
  FormFieldValidator<String?>? passwordValidator;
  late FormFieldValidator<String?> transcodingPortValidator;
  late FormFieldValidator<String?> streamingPortValidator;
  late FormFieldValidator<String?> httpPortValidator;

  void _setTextFieldValues() {
    nameController.value = nameController.value.copyWith(text: profile.name);
    addressController.value =
        addressController.value.copyWith(text: profile.address);
    usernameController.value =
        usernameController.value.copyWith(text: profile.username);
    passwordController.value =
        passwordController.value.copyWith(text: profile.password);
    transcodingPortController.value = transcodingPortController.value
        .copyWith(text: profile.transcodingPort.toString() ?? '');
    streamingPortController.value = streamingPortController.value
        .copyWith(text: profile.streamingPort.toString() ?? '');
    httpPortController.value = httpPortController.value
        .copyWith(text: profile.httpPort.toString() ?? '');
  }

  Future<bool> showWarningDialog(String text) async {
    return await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  MessageProvider.of(context).titleWarning,
                ),
                content: Text(
                  text,
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text(
                      MessageProvider.of(context).confirm.toUpperCase(),
                    ),
                  ),
                ],
              );
            }) ??
        false;
  }

  Future<bool> _checkHttpPort() async {
    if (!(await NetworkUtils.isPortOpen(
        profile.address, int.parse(profile.httpPort)))) {
      var message = MessageProvider.of(context)
          .warnHttpPortClosed(profile.address, profile.httpPort);
      message += '\n${MessageProvider.of(context).warnSaveTheProfileAnyway}';
      return await showWarningDialog(message);
    }
    return true;
  }

  Future<bool> _checkStreamingPort() async {
    if (!profile.streaming || profile.enigma == EnigmaType.enigma1) {
      return true;
    }
    if (!(await NetworkUtils.isPortOpen(
        profile.address, int.parse(profile.streamingPort)))) {
      var message = MessageProvider.of(context).warnStreamingPortClosed;
      message += '\n${MessageProvider.of(context).warnSaveTheProfileAnyway}';
      return await showWarningDialog(message);
    }
    return true;
  }

  Future<bool> _checkTranscodingPort() async {
    if (!profile.transcoding || !profile.streaming) {
      return true;
    }
    if (!(await NetworkUtils.isPortOpen(
        profile.address, int.parse(profile.transcodingPort)))) {
      var message = MessageProvider.of(context).warnTranscodingPortClosed;
      message += '\n${MessageProvider.of(context).warnSaveTheProfileAnyway}';
      return await showWarningDialog(message);
    }
    return true;
  }

  Future<bool> _checkUsernamePassword() async {
    if (StringHelper.stringIsNullOrEmpty(profile.username) &&
        StringHelper.stringIsNullOrEmpty(profile.password)) {
      var message = MessageProvider.of(context).questionEmptyUsernamePassword;
      message += '\n${MessageProvider.of(context).warnSaveTheProfileAnyway}';
      return await showWarningDialog(message);
    }
    return true;
  }

  Future<bool> validateForm() async {
    if (_formKey.currentState!.validate()) {
      widget.viewModel.displayCheckingPortsInfoMessage();
      if (!await _checkUsernamePassword()) {
        return false;
      }
      if (!await _checkHttpPort()) {
        return false;
      }
      if (!await _checkStreamingPort()) {
        return false;
      }
      if (!await _checkTranscodingPort()) {
        return false;
      }
      return true;
    } else {
      widget.viewModel.displayFormInvalidWarningMessage();
      return false;
    }
  }

  void saveForm() {
    widget.viewModel.onSaveProfile(profile.toProfile());
  }

  void _setListeners() {
    nameController.addListener(() {
      profile.name = nameController.text;
    });
    addressController
        .addListener(() => profile.address = addressController.text);
    usernameController
        .addListener(() => profile.username = usernameController.text);
    passwordController
        .addListener(() => profile.password = passwordController.text);
    transcodingPortController.addListener(
        () => profile.transcodingPort = transcodingPortController.text);
    streamingPortController.addListener(
        () => profile.streamingPort = streamingPortController.text);
    httpPortController
        .addListener(() => profile.httpPort = httpPortController.text);
  }

  void _setValidators() {
    nameValidator = (value) {
      if (value == null || value.isEmpty) {
        return MessageProvider.of(context).errInvalidProfileName;
      }
      return null;
    };

    addressValidator = (value) {
      if (value == null || value.isEmpty) {
        return MessageProvider.of(context).errInvalidAddress;
      }
      if (!NetworkUtils.isValidAddress(value)) {
        return MessageProvider.of(context).errInvalidAddress;
      }
      return null;
    };

    httpPortValidator = (value) {
      if (!NetworkUtils.isStringValidPort(value ?? '')) {
        return MessageProvider.of(context).errInvalidHttpPort;
      }
      return null;
    };

    usernameValidator = (value) {
      if (value == null || value.isEmpty) {
        if (passwordController.text.isNotEmpty) {
          return MessageProvider.of(context).errInvalidUsername;
        }
      }
      return null;
    };

    transcodingPortValidator = (value) {
      if (!profile.transcoding) {
        return null;
      }
      if (!NetworkUtils.isStringValidPort(value ?? '')) {
        return MessageProvider.of(context).errInvalidTranscodingPort;
      }
      return null;
    };

    streamingPortValidator = (value) {
      if (!profile.streaming || profile.enigma == EnigmaType.enigma1) {
        return null;
      }
      if (!NetworkUtils.isStringValidPort(value ?? '')) {
        return MessageProvider.of(context).errInvalidStreamingPort;
      }
      return null;
    };
  }

  void setEnigmaType(EnigmaType enigma) {
    setState(() {
      profile.enigma = enigma;
      if (profile.enigma == EnigmaType.enigma1) {
        profile.transcoding = false;
        profile.transcodingPort = '';
      }
    });
  }

  void setUseSsl(bool useSsl) {
    setState(() {
      profile.useSsl = useSsl;
    });
  }

  void setTranscoding(bool transcoding) {
    setState(() {
      profile.transcoding = transcoding;
    });
  }

  void setStreaming(bool streaming) {
    setState(() {
      profile.streaming = streaming;
    });
  }

  void setId(String id) {
    setState(() {
      profile.id = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      node: focusNode,
      child: Form(
        key: _formKey,
        autovalidateMode: widget.profile != null
            ? AutovalidateMode.always
            : AutovalidateMode.disabled,
        child: _InheritedProfileWidget(
          data: this,
          child: widget.child,
        ),
      ),
    );
  }
}
