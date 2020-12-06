import 'package:flutter/material.dart';
import '../../providers/auth_provider.dart';
import 'package:provider/provider.dart';
// voer hier een functie uit die in authscreen staat. Hier geven we de gegevens
// mee die vervolgens gebruikt/opgeslagen wordt in auth_screen

class AuthForm extends StatefulWidget {
  // final void Function(String email, String password) submitFn;
  // final bool isLoading;

  // AuthForm(this.submitFn, this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  var _isLoading = false;

  void _trySubmit() {
    final isValid = _formKey.currentState.validate(); // valideer de form
    FocusScope.of(context).unfocus(); // unfocus de softkeyboard

    if (isValid) {
      setState(
        () {
          _isLoading = true;
        },
      );
      _formKey.currentState.save();
      print(_userName);
      context
          .read<AuthProvider>()
          .submitForm(_userName, _userEmail, _userPassword, _isLogin);
    }
    setState(() {
      _isLoading = false;
    });

    // if (_isLogin) {
    //   context.read<AuthProvider>().signIn(_userEmail, _userPassword);
    // } else {
    //   context.read<AuthProvider>().signUp(_userEmail, _userPassword);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(children: <Widget>[
            if (!_isLogin)
              TextFormField(
                key: ValueKey('name'),
                // autocorrect: false,
                textCapitalization: TextCapitalization.none,
                // enableSuggestions: false,
                decoration: InputDecoration(labelText: 'Volledige naam'),
                validator: (value) {
                  if (value.isEmpty ||
                      value.contains(new RegExp(r'^[0-9]+$'))) {
                    return 'Voer een geldig naam in';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _userName = newValue;
                },
              ),
            TextFormField(
              key: ValueKey('email'),
              autocorrect: false,
              textCapitalization: TextCapitalization.none,
              enableSuggestions: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: 'E-mailadres'),
              validator: (value) {
                if (value.isEmpty || !value.contains('@')) {
                  return 'Voer een geldig e-mailadres in.';
                }
                return null;
              },
              onSaved: (newValue) {
                _userEmail = newValue;
              },
            ),
            TextFormField(
              key: ValueKey('password'),
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value.isEmpty || value.length < 8) {
                  return 'Password must be at least 8 characters long.';
                }
                return null;
              },
              onSaved: (newValue) {
                _userPassword = newValue;
              },
            ),
            RaisedButton(
              // color: Theme.of(context).primaryColor,
              onPressed: _trySubmit,
              child: _isLoading
                  ? CircularProgressIndicator()
                  : Text(_isLogin ? 'Login' : 'Registreer'),
            ),
            FlatButton(
              textColor: Theme.of(context).primaryColor,
              onPressed: () {
                setState(() {
                  _isLogin = !_isLogin;
                });
              },
              child: Text(_isLogin
                  ? "Maak een nieuw account aan"
                  : "Ik heb al een account"),
            )
          ]),
        ),
      ),
    );
  }
}
