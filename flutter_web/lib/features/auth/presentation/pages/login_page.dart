import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web/features/auth/presentation/bloc/product/auth_bloc.dart';
import 'package:flutter_web/features/auth/presentation/bloc/product/auth_event.dart';
import 'package:flutter_web/features/auth/presentation/bloc/product/auth_state.dart';
import 'package:flutter_web/features/language/lang.dart';
import 'package:flutter_web/features/products/presentation/bloc/product/product_event.dart';
import 'package:flutter_web/responsive/main_page_web.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    context.read<AuthBloc>().add(LoginEvent(
        password: _passwordController.text,
        username: _usernameController.text));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).translate('user_name')),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).translate('password')),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      _login();
                    },
                    child:
                        Text(AppLocalizations.of(context).translate('sign_in')))
              ],
            ),
          ),
        ));
  }
}
