import 'package:picshare/screens/components/rounded_button.dart';
import 'package:picshare/screens/components/rounded_input_field.dart';
import 'package:picshare/screens/components/rounded_password_field.dart';
import 'package:picshare/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        elevation: 0.0,
        title: Text('Sign in to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),*/
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Signin.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric( horizontal: 25.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20.0),
              Text(
                "Connexion",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
              /*TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.alternate_email),
                  labelText: 'Email',
                  
                ),
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),*/
              SizedBox(height: 40.0),
              RoundedInputField(
                hintText: "Adresse e-mail",
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              /*TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.vpn_key),
                  labelText: 'Mot de passe',
                ),
                keyboardType: TextInputType.visiblePassword ,
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),*/
              RoundedPasswordField(
                hintText: "Adresse e-mail",
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              /*RaisedButton(
                child: Text(
                  'Se connecter',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () async {
                  _auth.signInWithEmailAndPassword(email.trim(), password);
                },
              ),
              RaisedButton(
                child: Text(
                  "S'inscrire",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
               onPressed: () => widget.toggleView(),
              ),*/

              RoundedButton(
                text: "S'INSCRIRE",
                fontsize: 20,
                press: () async {
                  _auth.signInWithEmailAndPassword(email.trim(), password);
                },
              ),
              RoundedButton(
                text: "S'INSCRIRE",
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
            ],
          ),
        ),
      ),
    );
  }
}