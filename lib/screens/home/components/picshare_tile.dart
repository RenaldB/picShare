import 'package:flutter/material.dart';
import 'package:picshare/models/picshare.dart';

class PicShareTile extends StatelessWidget {

  final PicShare picShare;
  PicShareTile({ this.picShare });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[50],
            backgroundImage: AssetImage('assets/coffee_icon.png'),
          ),
          title: Text(picShare.picName),
          subtitle: Text('Takes ${5} sugar(s)'),
        ),
      ),
    );
  }
}