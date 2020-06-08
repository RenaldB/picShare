/**
 * 
 * NAVBAR
 * 
 */

import 'package:flutter/material.dart';
import 'package:picshare/services/auth.dart';
class Profil extends StatefulWidget {

  
  @override
  _Profil createState() => new _Profil();
  
}

class _Profil extends State<Profil> {
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text('Page de profil'),
      actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Log Out'),
            onPressed: (){
              _auth.signOut();
              Navigator.pop(context);
            },
            
          ),
          
        ],
    ) ,
    body: Center(
      child: Text(
        'Je suis la page de profil',
        textScaleFactor: 2.0,
        textAlign: TextAlign.center,
        style: TextStyle(),
      ),
    ),
    );
  }
}