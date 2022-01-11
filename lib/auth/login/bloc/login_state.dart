import 'package:nekidaem/auth/login/bloc/form_submission_status.dart';

class LoginState {
  final String username;
  final String password;
  final FormSubmissionStatus formStatus;

  bool get isValidUsername => username.length >= 4;
  bool get isValidPassword => password.length >= 8;

  bool get isValidUsernameErrorText => username.length >= 4 || username.isEmpty;
  bool get isValidPasswordErrorText => password.length >= 8 || password.isEmpty;

  LoginState({
    this.username = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  LoginState copyWith({
    String? username,
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}