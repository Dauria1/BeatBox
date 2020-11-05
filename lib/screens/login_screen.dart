import 'package:beat_box/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:beat_box/screens/registration_screen.dart';
import 'package:beat_box/widgets/common/custom_input.dart';
import 'package:beat_box/constants/navigation_constants.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = Screens.LOGIN;
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  void onPressSubmit() {
    _formKey.currentState.validate();
  }

  void onPressRegister(BuildContext context) {
    Navigator.of(context).pushNamed(RegistrationScreen.routeName);
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.primary,
        title: Text("Login Screen"),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login screen"),
              CustomInput(
                controller: emailController,
                placeholder: 'Email address',
                margin: EdgeInsets.only(bottom: 20),
                validator: (String value) {
                  Pattern pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regex = new RegExp(pattern);
                  return (!regex.hasMatch(value)) ? 'Not an email' : null;
                },
              ),
              CustomInput(
                  controller: passwordController,
                  placeholder: 'Password',
                  margin: EdgeInsets.only(bottom: 20),
                  obscureText: true,
                  validator: (String value) =>
                      value.isEmpty ? 'Please enter password' : null),
              RaisedButton(child: Text("Login"), onPressed: onPressSubmit),
              FlatButton(
                  child: Text("To Registration"),
                  onPressed: () => onPressRegister(context)),
            ],
          ),
        ),
      ),
    );
  }
}
