import "package:cloud_firestore/cloud_firestore.dart";

class DatabaseService {
  final String uid;
  final CollectionReference teas =
      FirebaseFirestore.instance.collection("teas");

  DatabaseService({this.uid = ""});

  Stream<QuerySnapshot> get teaCollection {
    return teas.snapshots();
  }

  Future<void> setUserTeaPreference(String teaName, double strength) async {
    return await teas.doc(uid).set({"Name": teaName, "Strength": strength});
  }
}
