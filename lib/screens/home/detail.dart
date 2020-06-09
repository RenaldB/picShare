import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  Detail(this.image);
  final String image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: <Widget>[
          Hero(child: Image.asset(image), tag: image,),
          Container(
            margin: EdgeInsets.all(20),
            child: Text(
              "Lol c'est un test",
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Text(
              "C'est la mort",
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          )
          ],
      ),
    );
  }
}
