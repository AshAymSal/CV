import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServicesCaller {
  FirebaseServicesCaller._();

  static final instance = FirebaseServicesCaller._();

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    final reference = _firebaseFirestore.doc(path);
    print('$path: $data');

    // set without merge will overwrite a document or create it if it doesn't exist yet
    // set with merge will update fields in the document or create it if it doesn't exists//
    // update will update fields but will fail if the document doesn't exist
    // create will create the document but fail if the document already exists

    await reference.set(data, SetOptions(merge: merge));
  }

  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    final reference = _firebaseFirestore.collection(path);
    print('$path: $data');
    await reference.add(data);
  }

  Future<T> getData<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String? documentId) builder,
  }) async {
    final reference = _firebaseFirestore.doc(path);
    final value = await reference.get();
    if (value.exists) {
      return builder(value.data(), value.id);
    }
    return builder(null, null);
  }

  Future<void> deleteData({required String path}) async {
    final reference = _firebaseFirestore.doc(path);
    print('delete: $path');
    await reference.delete();
  }

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentId) builder,
    Query<Map<String, dynamic>>? Function(Query<Map<String, dynamic>> query)?
        queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query<Map<String, dynamic>> query = _firebaseFirestore.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    final Stream<QuerySnapshot<Map<String, dynamic>>> snapshots =
        query.snapshots();

    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) => builder(snapshot.data(), snapshot.id))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  Stream<T> documentStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documetnId) builder,
  }) {
    final DocumentReference<Map<String, dynamic>> reference =
        _firebaseFirestore.doc(path);
    final Stream<DocumentSnapshot<Map<String, dynamic>>> snapshots =
        reference.snapshots();
    return snapshots.map((snapshot) => builder(snapshot.data(), snapshot.id));
  }
}
