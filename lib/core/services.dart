import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_app/core/data/user.model.dart';
import 'package:diet_app/core/utils/local_storage.utils.dart';

class FireBaseUtils{
  static UserModel? user;
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static pushToFireBase(UserModel user) {
    db.collection('Users').add(user.toJson()).then((value) => LocalStorageUtils.setMyDocId(value.id));
  }
}