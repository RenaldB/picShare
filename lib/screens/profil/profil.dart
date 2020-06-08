/**
 * 
 * NAVBAR
 * 
 */

import 'package:flutter/material.dart';
class Profil extends StatefulWidget {

  
  @override
  _Profil createState() => new _Profil();
  
}

class _Profil extends State<Profil> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text('Page de profil')
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