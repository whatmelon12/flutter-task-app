import 'package:flutter/material.dart';
import 'package:todoeyflutter/components/round_button.dart';
import 'package:todoeyflutter/constants/styles.dart';
import 'package:todoeyflutter/model/account.dart';

class LoginForm extends StatefulWidget {
  final Function(Account) onFormSaved;

  const LoginForm({Key key, @required this.onFormSaved}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _autoValidate;

  GlobalKey<FormState> _formKey;

  TextEditingController _emailTextEditingController;
  TextEditingController _passwordTextEditingController;

  @override
  void initState() {
    super.initState();

    _autoValidate = false;
    _formKey = GlobalKey<FormState>();
    _emailTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            controller: _emailTextEditingController,
            decoration: kTextFieldDecoration.copyWith(
              hintText: "Email"
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) => _validateFormField(value, "Email"),
          ),
          SizedBox(
            height: 8.0,
          ),
          TextFormField(
            controller: _passwordTextEditingController,
            obscureText: true,
            decoration: kTextFieldDecoration.copyWith(
                hintText: "Password"
            ),
            validator: (value) => _validateFormField(value, "Password"),
          ),
          RoundButton(
            label: 'Login',
            onPressed: _onLoginPressed,
          )
        ],
      ),
    );
  }

  _onLoginPressed() {
    setState(() {
      _autoValidate = true;
    });

    if(_formKey.currentState.validate()) {
      widget.onFormSaved(
        Account(
          email: _emailTextEditingController.text,
          password: _passwordTextEditingController.text
        )
      );
    }
  }

  String _validateFormField(String value, String fieldName) {
    if(value.isEmpty) {
      return "$fieldName cannot be empty.";
    }

    return null;
  }

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }
}
