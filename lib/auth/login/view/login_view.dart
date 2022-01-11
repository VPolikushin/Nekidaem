
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekidaem/auth/repository/auth_repository.dart';
import 'package:nekidaem/auth/login/bloc/form_submission_status.dart';
import 'package:nekidaem/auth/login/bloc/login_bloc.dart';
import 'package:nekidaem/auth/login/bloc/login_event.dart';
import 'package:nekidaem/auth/login/bloc/login_state.dart';

class LoginView extends StatelessWidget {
  static const routeName = '/login';
  LoginView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  String? _username, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Kanban'),
      ),
      body: BlocProvider(
        create: (context) => LoginBloc(
          authRepository: context.read<AuthRepository>(),
        ),
        child: _loginForm(context),
      )
    );
  }
  
  Widget _loginForm(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      if (state.formStatus is FormSubmitting) {
        return const CircularProgressIndicator();
      }
      if (state.formStatus is InitialFormStatus) {
        return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            _usernameField(),

            const SizedBox(height: 30),
            _passwordField(),

            const SizedBox(height: 30),
            SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: _loginButton(),
            ),
          ],
        ),
      ),
    );
      }
      if (state.formStatus is SubmissionFailed) {
        return Text(state.formStatus.toString());
      }
      return const Text('None');
  });
  }

  Widget _usernameField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        textAlign: TextAlign.center,
        validator: (value) => state.isValidUsername
        ? null
        : 'Minimum is 4 characters',
        onChanged: (value) {
          _username = value;
            return context.read<LoginBloc>().add(
            LoginUsernameChanged(username: value),
          );
        },
        decoration: InputDecoration(
          errorText: state.isValidUsernameErrorText
              ? null
              : 'Minimum is 4 characters',
          hintText: 'Enter your username',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      );
    });
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
      return TextFormField(
        obscureText: true,
        textAlign: TextAlign.center,
        validator: (value) => state.isValidPassword
            ? null
            : 'Minimum is 8 characters',
        onChanged: (value) {
          _password = value;
          return context.read<LoginBloc>().add(
          LoginPasswordChanged(password: value),
          );
        },
        decoration: InputDecoration(
          errorText: state.isValidPasswordErrorText
              ? null
              : 'Minimum is 8 characters',
          hintText: 'Enter your password',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      );
    });
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        onPressed: () {
          if(_formKey.currentState!.validate()) {
            context.read<LoginBloc>().add(LoginSubmitted(username: _username, password: _password));
            // Navigator.of(context).pop();
            Navigator.of(context).pushNamed('/tabBar');
          }
        },
        child: const Text('Log in'),
      );
    });
  }
}



