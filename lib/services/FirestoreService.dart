import 'package:clippad/model/User.dart';
import 'package:clippad/services/GoogleAuth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  FirebaseFirestore fs = FirebaseFirestore.instance;
  FireStoreService();

  Future<void> updateData(String newData) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    googleAuthService.getLoggedUser().then((acc) {
      if (acc == null)
        print("Acc is null.");
      else
        users.doc(acc.id).set(
            User(acc.id, newData).toJson(), SetOptions(mergeFields: ["data"]));
    });
  }
}

final fireStoreService = FireStoreService();
