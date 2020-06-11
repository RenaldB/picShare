import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:picshare/models/picshare.dart';
import 'package:picshare/models/user.dart';
import 'package:picshare/services/database.dart';
import 'package:provider/provider.dart';

class Uploader extends StatefulWidget {
  final File file;

  Uploader({Key key, this.file}) : super(key: key);

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://picshare-fe309.appspot.com');

  StorageUploadTask _uploadTask;

  /// Starts an upload task
  void _startUpload(DatabaseService db) {
    /// Unique file name for the file
    String filePath = 'images/${DateTime.now()}.png';
    final StorageReference ref = _storage.ref().getRoot().child(filePath);
    String url = '';
    setState(() async {
      _uploadTask = ref.putFile(widget.file);
      _uploadTask.onComplete.then((value) => getIt(db));
    });
    print(url);
  }
  void getIt (DatabaseService db ) async {
    StorageTaskSnapshot storageSnapshot = await _uploadTask.onComplete;
    var downloadUrl = await storageSnapshot.ref.getDownloadURL();
    var url = downloadUrl;
    db.updatePicShare(PicShare(picPath: url, addedDate: DateTime.now(), uid: db.uid));
    //print(url);
    //now use your url of the image you already upliaded to the storage
    //you can save the url in the cloud database ...
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    DatabaseService _db = DatabaseService(uid: user.uid);
    if (_uploadTask != null) {
      /// Manage the task state and event subscription with a StreamBuilder
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (_, snapshot) {
            var event = snapshot?.data?.snapshot;

            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;

            return AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    if (_uploadTask.isComplete) Text('Image enregistré 🎉'),

                    if (_uploadTask.isPaused)
                      FlatButton(
                        child: Icon(Icons.play_arrow),
                        onPressed: _uploadTask.resume,
                      ),

                    if (_uploadTask.isInProgress)
                      FlatButton(
                        child: Icon(Icons.pause),
                        onPressed: _uploadTask.pause,
                      ),

                    // Progress bar
                    LinearProgressIndicator(value: progressPercent),
                    Text('${(progressPercent * 100).toStringAsFixed(2)} % '),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Terminé'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    } else {
      // Allows user to decide when to start the upload
      return FlatButton.icon(
          label: Text('Ajouter'),
          icon: Icon(Icons.cloud_upload),
          onPressed: () => {
                _startUpload(_db),
                
              });
    }
  }
}