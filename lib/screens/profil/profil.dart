/**
 * 
 * Page de profil
 * 
 */

import 'package:flutter/material.dart';
import '../components/navbar.dart';
void openPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(
    builder: (BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(
          title: const Text('Profil'),
          backgroundColor: Colors.black,
        ),
        body: const Center(
          child: Text(
            'Page de profil',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
        
        bottomNavigationBar: NavBar(),
      );
    },
  ));
}