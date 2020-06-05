/**
 * 
 * NAVBAR
 * 
 */

import 'package:flutter/material.dart';
import '../profil/profil.dart';
class NavBar extends StatefulWidget {



  @override
  _NavBar createState() => new _NavBar();

}

class _NavBar extends State<NavBar> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new BottomAppBar(
        color: Colors.black,
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
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    //_myPage.jumpToPage(0);
                  });
                },
              ),
              IconButton(
                iconSize: 30.0,
                icon: Icon(Icons.search),
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    //_myPage.jumpToPage(1);
                  });
                },
              ),
              IconButton(
                iconSize: 30.0,
                icon: Icon(Icons.notifications),
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    // _myPage.jumpToPage(2);
                  });
                },
              ),
              IconButton(
                iconSize: 30.0,
                icon: Icon(Icons.list),
                color: Colors.red,
                onPressed: () {
                 openPage(context);
                },
              )
            ],
          ),
        ),
      );
  }
}