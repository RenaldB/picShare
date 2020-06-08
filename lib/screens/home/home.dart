import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:picshare/screens/components/navbar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:picshare/screens/home/detail.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StaggeredGridView.count(
        crossAxisCount: 4,
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
      bottomNavigationBar:
          BottomNavigationBar(type: BottomNavigationBarType.fixed, items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text("Home"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          title: Text("Following"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          title: Text("Notifications"),
        ),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            backgroundColor: Colors.grey,
            child: Text("S"),
          ),
          title: Text("Profil"),
        )
      ]),
    );
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
          child: Hero(
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) =>
                            Detail("assets/images/stream/$i.png")));
              },
              child: Image.asset("assets/images/stream/$i.png"),
            ),
            tag: "assets/images/stream/$i.png",
          )),
    );
  }
}
