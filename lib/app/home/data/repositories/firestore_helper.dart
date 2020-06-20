
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';


// Repository ???
class FirestoreHelper {

  FirestoreHelper._();
  static final instance = FirestoreHelper._();

  Future<void> setData({String path, Map<String, dynamic> data}) async {
    final reference = Firestore.instance.document(path);
    await reference.setData(data);
  }

  Stream<List<T>> collectionStream<T>({@required String path, @required T builder(Map<String, dynamic> data)}) {
    final reference = Firestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) =>
        snapshot.documents.map((document) => builder(document.data)).toList());
  }

}