import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDataSource {
  FirebaseDataSource({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Future<Map<String, dynamic>> fetchDocument(String path) async {
    final snapshot = await _firestore.doc(path).get();
    final data = snapshot.data() ?? <String, dynamic>{};
    return {...data, 'id': snapshot.id};
  }

  Future<List<Map<String, dynamic>>> fetchCollection(String path) async {
    final snapshot = await _firestore.collection(path).get();
    return snapshot.docs
        .map((doc) => {...doc.data(), 'id': doc.id})
        .toList();
  }

  Future<void> setDocument(String path, Map<String, dynamic> data) async {
    await _firestore.doc(path).set(data, SetOptions(merge: true));
  }
}
