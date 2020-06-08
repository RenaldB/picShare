import 'package:picshare/screens/components/rounded_button.dart';
import 'package:picshare/screens/components/rounded_input_field.dart';
import 'package:picshare/screens/components/rounded_password_field.dart';
import 'package:picshare/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     /* backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign up to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),*/
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/astronaut-minimalist-ss.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Inscription",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
              /*TextFormField(
                validator: (val) => val.isEmpty ? 'Entrez votre adresse e-mail' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.alternate_email),
                  labelText: 'Email',
                  
                ),
              ),*/
              SizedBox(height: 40.0),
              RoundedInputField(
                hintText: "Adresse e-mail",
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              
              //SizedBox(height: 20.0),
              /*TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.vpn_key),
                  labelText: 'Mot de passe',
                ),
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Le mot de passe doit au moins contenir 6 lettres' : null,
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
              RoundedButton(
                text: "S'INSCRIRE",
                fontsize: 20,
                press: () async {
                  if(_formKey.currentState.validate()){
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if(result == null) {
                      setState(() {
                        error = 'Please supply a valid email';
                      });
                    }
                  }
                },
              ),
              /*RaisedButton(
                child: Text(
                  "S'inscrire",
                  style: TextStyle(fontSize: 20,color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if(result == null) {
                      setState(() {
                        error = 'Please supply a valid email';
                      });
                    }
                  }
                }
              ),*/
              RoundedButton(
                text: "Se connecter",
                fontsize: 15,
                press: () => widget.toggleView(),
              ),
              /*RaisedButton(
                child: Text(
                  "Se connecter",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
               onPressed: () => widget.toggleView(),
              ),*/
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