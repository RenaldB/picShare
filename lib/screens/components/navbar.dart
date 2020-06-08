/// 

/// NAVBAR

/// 


import 'package:flutter/material.dart';
import '../profil/profil.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBar createState() => new _NavBar();
}

class _NavBar extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return new BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Container(
        margin: EdgeInsets.only(left: 25.0, right: 25.0),
        height: 60,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              iconSize: 30.0,
              icon: Icon(Icons.home),
              onPressed: () {
                setState(() {
                  //_myPage.jumpToPage(0);
                });
              },
            ),
            IconButton(
              iconSize: 30.0,
              icon: Icon(Icons.people),
              onPressed: () {
                setState(() {
                  //_myPage.jumpToPage(1);
                });
              },
            ),
            IconButton(
              iconSize: 30.0,
              icon: Icon(Icons.notifications),
              onPressed: () {
                setState(() {
                  // _myPage.jumpToPage(2);
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ],
        ),
      ),
    );
  }

  void pageProfil() {
    print("Open");
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      print('to Profil');
      return Profil();
    }));
  }
}
