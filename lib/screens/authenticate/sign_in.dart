import 'package:picshare/screens/components/rounded_button.dart';
import 'package:picshare/screens/components/rounded_input_field.dart';
import 'package:picshare/screens/components/rounded_password_field.dart';
import 'package:picshare/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:picshare/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Signin.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric( horizontal: 25.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Connexion",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
              RoundedInputField(
                hintText: "Adresse e-mail",
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              RoundedPasswordField(
                hintText: "Adresse e-mail",
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              RoundedButton(
                text: "SE CONNECTER",
                fontsize: 20,
                press: () async {
                  if(_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic res = await _auth.signInWithEmailAndPassword(email, password);
                    if(res == null){
                      setState(() {
                        error = 'Adresse email ou mot de passe erroné(es)';
                        loading = false;
                      });
                    }
                  }
                },
              ),
              RoundedButton(
                text: "S'inscrire",
                fontsize: 15,
                press :() => widget.toggleView(),
              ),
              FlatButton(
                child: Text(
                  'Continuer sans se connecter',
                  style: TextStyle(fontSize: 9)
                ),
                onPressed: () async {
                  _auth.signInAnon();
                },
              ),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}