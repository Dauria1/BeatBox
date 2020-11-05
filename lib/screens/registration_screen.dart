import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:beat_box/widgets/common/custom_input.dart';
import 'package:beat_box/constants/navigation_constants.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class RegistrationScreen extends StatefulWidget {
  static const routeName = Screens.REGISTRATION;
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void onPressSubmit() async {
    bool valid = _formKey.currentState.validate();
    if (!valid) return;

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a new User 👍"),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text("Registration Screen"),
              CustomInput(
                controller: emailController,
                placeholder: 'Email address',
                margin: EdgeInsets.only(bottom: 20),
                validator: (String value) {
                  Pattern pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regex = new RegExp(pattern);
                  return (!regex.hasMatch(value))
                      ? 'Invalid Email adress'
                      : null;
                },
              ),
              CustomInput(
                  controller: passwordController,
                  placeholder: 'Password',
                  margin: EdgeInsets.only(bottom: 20),
                  obscureText: true,
                  validator: (String value) =>
                      value.isEmpty ? 'Please enter password' : null),
              RaisedButton(
                  child: Text("Register new user"), onPressed: onPressSubmit),
            ],
          ),
        ),
      ),
    );
  }
}
