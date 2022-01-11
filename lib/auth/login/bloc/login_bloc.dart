import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekidaem/auth/repository/auth_repository.dart';
import 'package:nekidaem/auth/login/bloc/form_submission_status.dart';
import 'package:nekidaem/auth/login/bloc/login_event.dart';
import 'package:nekidaem/auth/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository? authRepository;

  LoginBloc({this.authRepository}) : super(LoginState());


  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginUsernameChanged) {
      yield state.copyWith(username: event.username);

    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);

    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        await authRepository!.login(event.username, event.password);
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e as Exception));
      }
    }
  }
}