import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:picshare/screens/components/navbar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:picshare/screens/home/detail.dart';
import '../profil/profil.dart';
import 'package:picshare/services/auth.dart';

import 'package:universal_platform/universal_platform.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AuthService _auth = AuthService();
  bool showUserDetails = false;
//Detecte la plateform
  bool isIos = UniversalPlatform.isIOS;
  bool isWeb = UniversalPlatform.isWeb;
  bool isMacOS = UniversalPlatform.isMacOS;
  bool isWindows = UniversalPlatform.isWindows;
  bool isLinux = UniversalPlatform.isLinux;
  bool isAndroid = UniversalPlatform.isAndroid;
  bool isFuchsia = UniversalPlatform.isFuchsia;
  var valCrossAxisCount;  //Nombre de colonne

  @override
  Widget build(BuildContext context) {

    //Détecte si si en Mode Portrait ou Paysage
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    //Si mode portrait
    if (isPortrait == true) {
      // is portrait
      valCrossAxisCount = 4;
    } 
    //Si mode Paysage
    else {
      // is landscape
      valCrossAxisCount = 8;
    }

    return Scaffold(
      endDrawer: Drawer(
        // column holds all the widgets in the drawer
        child: Column(
          children: <Widget>[
            Expanded(
              // ListView contains a group of widgets that scroll inside the drawer
              child: ListView(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text("BOOZ Rénald"),
                    accountEmail: Text(
                      "Web: ${UniversalPlatform.isWeb} \n "
                      "MacOS: ${UniversalPlatform.isMacOS} \n"
                      "Windows: ${UniversalPlatform.isWindows} \n"
                      "Linux: ${UniversalPlatform.isLinux} \n"
                      "Android: ${UniversalPlatform.isAndroid} \n"
                      "IOS: ${UniversalPlatform.isIOS} \n"
                      "Fuschia: ${UniversalPlatform.isFuchsia} \n",
                    ),
                  ),
                  ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Profil'),
                      onTap: () {
                        pageProfil();
                      }),
                ],
              ),
            ),
            // This container holds the align
            Container(
                // This align moves the children to the bottom
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    // This container holds all the children that will be aligned
                    // on the bottom and should not scroll with the above ListView
                    child: Container(
                        child: Column(
                      children: <Widget>[
                        Divider(),
                        ListTile(
                            leading: Icon(Icons.settings),
                            title: Text('Settings')),
                        ListTile(
                            leading: Icon(
                              Icons.do_not_disturb,
                              color: Colors.red,
                            ),
                            title: Text(
                              'Déconnexion',
                              style: TextStyle(color: Colors.red),
                            ),
                            onTap: () {
                              _auth.signOut();
                            }),
                      ],
                    ))))
          ],
        ),
      ),
      endDrawerEnableOpenDragGesture: true,
      body: StaggeredGridView.count(
        crossAxisCount: valCrossAxisCount,
        children: List.generate(
          10,
          (int i) {
            return _Tile(i);
          },
        ),
        staggeredTiles: List.generate(10, (int index) {
          return StaggeredTile.fit(2);
        }),
      ),
      bottomNavigationBar: NavBar(),
    );
  }

  ///
  ///Redirection pour la page de profil
  void pageProfil() {
    print("Open");
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      print('to Profil');
      return Profil();
    }));
  }
}

class _Tile extends StatelessWidget {
  _Tile(this.i);

  final int i;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => Detail("assets/images/stream/$i.png"),
              ),
            );
          },
          child: Hero(
            child: Image.asset("assets/images/stream/$i.png"),
            tag: "assets/images/stream/$i.png",
          ),
        ),
      ),
    );
  }
}
