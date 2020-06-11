  

import 'package:flutter/material.dart';
import 'package:picshare/models/picshare.dart';
import 'package:picshare/screens/home/components/picshare_tile.dart';
import 'package:provider/provider.dart';

class PicShareList extends StatefulWidget {
  @override
  _PicShareState createState() => _PicShareState();
}

class _PicShareState extends State<PicShareList> {
  @override
  Widget build(BuildContext context) {

    final picshares = Provider.of<List<PicShare>>(context) ?? [];

    return ListView.builder(
      itemCount: picshares.length,
      itemBuilder: (context, index) {
        return PicShareTile(picShare: picshares[index]);
      },
    );
  }
}