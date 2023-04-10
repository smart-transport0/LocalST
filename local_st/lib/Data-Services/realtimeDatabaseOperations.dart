import 'package:firebase_database/firebase_database.dart';

class RealTimeDatabase {
  // Realtime database CRUD operations
  Future<void> updateDataIntoRTDB(String path, var data) async {
    var dbRef = FirebaseDatabase.instance.reference().child(path);
    await dbRef.update(data);
  }

  Future<void> setDataIntoRTDB(String path, var data) async {
    var dbRef = FirebaseDatabase.instance.reference().child(path);
    await dbRef.set(data);
  }

  Future<void> deleteDataIntoRTDB(String path) async {
    var dbRef = FirebaseDatabase.instance.reference().child(path);
    await dbRef.remove();
  }

  Future<DataSnapshot> getDataIntoRTDB(String path) async {
    var dbRef = FirebaseDatabase.instance.reference().child(path);
    var snapshot = await dbRef.get();
    return snapshot;
  }
}