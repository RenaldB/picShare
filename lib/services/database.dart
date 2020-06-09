import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:picshare/models/picshare.dart';
import 'package:picshare/models/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });
  // collection reference
  final CollectionReference picshareCollection = Firestore.instance.collection('picshare');

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
  Future<void> updateUserData(String nickname, DateTime birthDate) async {
    return await picshareCollection.document(uid).setData({
      'nickname': nickname,
      'birthDate': birthDate
    });
  }
}