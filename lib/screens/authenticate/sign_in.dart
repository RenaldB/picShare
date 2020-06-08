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
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 15.0),
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
              //SizedBox(height: 40.0),
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
              //SizedBox(height: 20.0),
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
                text: "SE CONNECTER",
                fontsize: 20,
                press: () async {
                  if(_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic res = _auth.signInWithEmailAndPassword(email.trim(), password);
                    if(res == null){
                      setState(() {
                        error = 'Adresse email ou mot de passe erronée/s';
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
              //SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}