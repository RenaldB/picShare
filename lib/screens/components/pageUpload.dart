import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'uploadImage.dart';

class Gallery extends StatefulWidget {
  Gallery({Key key, @required this.text}) : super(key: key);
  final String text;

  @override
  _Gallery createState() => new _Gallery(text: text);
}

class _Gallery extends State<Gallery> {
  /// Active image file
  File _imageFile;
  String text;
  _Gallery({this.text});
  double imageWidth;
  double imageHeight;

  /// Cropper plugin
  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
      // ratioX: 1.0,
      // ratioY: 1.0,
      // maxWidth: 512,
      // maxHeight: 512,
    );

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    final _picker = ImagePicker();
    PickedFile selected = await _picker.getImage(source: source);

    setState(() {
      if (selected.path.isNotEmpty) _imageFile = File(selected.path);
    });
  }

  /// Remove image
  void _clear() {
    setState(() => _imageFile = null);
  }

  @override
  Widget build(BuildContext context) {
    //Détecte si si en Mode Portrait ou Paysage
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    //Si mode portrait
    if (isPortrait == true) {
      // is portrait
      imageWidth = 643;
      imageHeight = 500;
    }
    //Si mode Paysage
    else {
      // is landscape
      imageHeight = 197;
    }
    if (_imageFile == null) {
      print(text);
      if (text == "gallery") {
        _pickImage(ImageSource.gallery);
      }
      if (text == "photo") {
        _pickImage(ImageSource.camera);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une image'),
      ),
      // Select an image from the camera or gallery
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          margin: EdgeInsets.only(left: 75.0, right: 75.0),
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.photo_camera),
                onPressed: () => _pickImage(ImageSource.camera),
              ),
              IconButton(
                icon: Icon(Icons.photo_library),
                onPressed: () => _pickImage(ImageSource.gallery),
              ),
            ],
          ),
        ),
      ),

      // Preview the image and crop it
      body: ListView(
        children: <Widget>[
          if (_imageFile != null) ...[
            Image.file(
              _imageFile,
              height: imageHeight,
              width: imageWidth,
            ),
            Container(
              child: Container(
                margin: EdgeInsets.only(left: 25.0, right: 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Uploader(file: _imageFile),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FlatButton(
                          child: Icon(Icons.crop),
                          onPressed: _cropImage,
                        ),
                        FlatButton(
                          child: Icon(Icons.refresh),
                          onPressed: _clear,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
