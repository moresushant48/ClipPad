import 'package:clippad/model/User.dart';
import 'package:clippad/services/GoogleAuth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  FirebaseFirestore fs = FirebaseFirestore.instance;

  FireStoreService() {}

  Future<void> updateData(String newData) async {
    googleAuthService.getLoggedUser().then((acc) {
      if (acc == null)
        print("Acc is null.");
      else
        fs.collection("users").doc(acc.id).set(
            User(acc.id, newData).toJson(), SetOptions(mergeFields: ["data"]));
    });
  }
}

final fireStoreService = FireStoreService();
