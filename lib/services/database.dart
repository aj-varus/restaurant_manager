import "package:cloud_firestore/cloud_firestore.dart";
import 'package:restaurant_manager/models/tea.dart';

class DatabaseService {
  final String uid;
  final CollectionReference teas =
      FirebaseFirestore.instance.collection("teas");

  DatabaseService({this.uid = ""});

  List<Tea> _teaListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Tea(name: doc.get("name"), strength: doc.get("strength"));
    }).toList();
  }

  Future<List<Tea>> get getInitialData async {
    return _teaListFromSnapshot(await teas.get());
  }

  Stream<List<Tea>> get teaCollection {
    return teas.snapshots().map(_teaListFromSnapshot);
  }

  Future<void> setUserTeaPreference(String teaName, double strength) async {
    return await teas.doc(uid).set({"Name": teaName, "Strength": strength});
  }
}
