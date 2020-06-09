import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:picshare/screens/components/navbar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:picshare/screens/home/detail.dart';
import '../profil/profil.dart';
import '../components/uploadImage2.dart';
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
  var valCrossAxisCount; //Nombre de colonne

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
        child: Container(
          color: Theme.of(context).primaryColorDark,
          child: ListView(
            children: <Widget>[
              new Container(
                child: new UserAccountsDrawerHeader(
                  accountName: Text(
                    "Rénald Booz",
                    style: new TextStyle(fontSize: 15.0),
                  ),
                  accountEmail: Text(
                    "renaldbooz@live.fr",
                    style: new TextStyle(fontSize: 15.0),
                  ),
                  currentAccountPicture: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: new ExactAssetImage(
                            'assets/images/photo profil.jpg'),
                      ),
                    ),
                  ),
                ),
              ),
              new Container(
                child: ListTile(
                    leading: Icon(
                      Icons.person,
                    ),
                    title: Text(
                      'Profil',
                      style: new TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                    onTap: () {
                      pageProfil();
                    }),
              ),
              new Divider(
                height: 5.0,
                color: Colors.black45,
              ),
              new Container(
                child: ListTile(
                    leading: Icon(
                      Icons.image,
                    ),
                    title: Text(
                      'Ajout image',
                      style: new TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                    onTap: () {
                      pageUpload();
                    }),
              ),
              new Divider(
                height: 5.0,
                color: Colors.black45,
              ),
              new Container(
                child: new ListTile(
                  title: Text(
                    "Paramètre",
                    style: new TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                  leading: Icon(Icons.settings),
                  onTap: () {
                      //UploadImageDemoState().startUpload();
                    }
                ),
              ),
              new Divider(
                height: 5.0,
                color: Colors.black45,
              ),
              new Container(
                child: new ListTile(
                  title: Text(
                    "Déconnexion",
                    style: new TextStyle(fontSize: 18.0, color: Colors.red),
                  ),
                  leading: Icon(Icons.do_not_disturb, color: Colors.red),
                  onTap: () {
                      _auth.signOut();
                    }
                ),
              ),
              new Divider(
                height: 5.0,
                color: Colors.black45,
              ),
            ],
          ),
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

  ///Redirection pour la page de profil
  void pageProfil() {
    print("Open");
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      print('to Profil');
      return Profil();
    }));
  }

  void pageUpload() {
    print("Open");
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      print('to upload image');
      return ImageCapture();
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
