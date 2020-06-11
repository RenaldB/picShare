import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Detail extends StatelessWidget {
  Detail(this.image);
  final String image;
  double imageWidth;
  double imageHeight;

  @override
  Widget build(BuildContext context) {
    //Détecte si si en Mode Portrait ou Paysage
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    //Si mode portrait
    if (isPortrait == true) {
      // is portrait
    }
    //Si mode Paysage
    else {
      // is landscape
      imageWidth = 500;
      imageHeight = 500;
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 1,
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) => new Container(
          child: Column(
            children: <Widget>[
              Hero(
                child: Image.network(
                  image,
                  height: imageHeight,
                  width: imageWidth,
                ),
                tag: image,
              ),
              Container(
                  margin: EdgeInsets.all(20),
                  child: Text(
                    "Lol c'est un test",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              Container(
                  margin: EdgeInsets.all(20),
                  child: Text(
                    "C'est la mort",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
        staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(2, index.isEven ? 2 : 1),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
    );
  }
}
