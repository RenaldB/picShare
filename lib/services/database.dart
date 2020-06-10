import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:picshare/models/picshare.dart';
import 'package:picshare/models/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });
  // collection reference
  final CollectionReference picshareCollection = Firestore.instance.collection('picshare');
  final CollectionReference userCollection = Firestore.instance.collection('user');

  Future<void> updatePicShare(PicShare pic) async {
    return await picshareCollection.document(pic.picName).setData({
      //'pic' : pic;
      'picName': pic.picName,
      'picPath': pic.picPath,
      'picDesc': pic.picDesc,
      'addedDate': pic.addedDate,
      'tags': pic.tags,
      'uid': pic.uid,
    });
  }
  List<PicShare> _picShareListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      //print(doc.data);
      return PicShare(
        picName: doc.data['picName'] ?? '',
        picPath: doc.data['picPath'] ?? '',
        picDesc: doc.data['picDesc'] ?? '',
        addedDate: DateTime.tryParse(doc.data['addedDate']) ?? DateTime.now() ,
        tags: (doc.data['tags'] ?? '').split(';')
      );
    }).toList();
  }
  Stream<List<PicShare>> get picshare {
    return picshareCollection.snapshots()
      .map(_picShareListFromSnapshot);
  }
  User _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return User(
      uid: uid,
      nickname: snapshot.data['nickname'],
      email: snapshot.data['email']
    );
  }
  Future<void> updateUserData(String nickname, DateTime dateBirth) async {
    return await userCollection.document(uid).setData({
      'nickname': nickname,
      'dateBirth': dateBirth,
      'dateInscription' : DateTime.now()
    });
  }
}