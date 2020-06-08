import 'package:picshare/screens/components/rounded_button.dart';
import 'package:picshare/screens/components/rounded_input_field.dart';
import 'package:picshare/screens/components/rounded_password_field.dart';
import 'package:picshare/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:picshare/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: SingleChildScrollView(
              child: Container(
                height:  MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage("assets/images/astronaut-minimalist-ss.jpg"),
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40),
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
                        text: "S'INSCRIRE",
                        fontsize: 20,
                        press: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth
                                .registerWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = "L'adresse email n'est pas valide";
                              });
                            }
                          }
                        },
                      ),
                      RoundedButton(
                        text: "Se connecter",
                        fontsize: 15,
                        press: () => widget.toggleView(),
                      ),
                      FlatButton(
                        child: Text('Continuer sans se connecter',
                            style: TextStyle(fontSize: 9)),
                        onPressed: () async {
                          _auth.signInAnon();
                        },
                      ),
                      Text(
                        error,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
