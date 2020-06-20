
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:time_tracker_flutter/app/home/data/api_path.dart';
import 'package:time_tracker_flutter/app/home/data/repositories/firestore_helper.dart';
import 'package:time_tracker_flutter/app/home/domain/repositories/database.dart';
import 'package:time_tracker_flutter/app/home/domain/models/job.dart';

// UseCase ???
class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  final String uid;

  final _firestoreHelper = FirestoreHelper.instance;

  Future<void> createJob(Job job) async {
    final path = APIPath.job(uid, 'job_abc');
    await _firestoreHelper.setData(path: path, data: job.toMap());
  }
  
  Stream<List<Job>> jobsStream() {
    final path = APIPath.jobs(uid);
    return _firestoreHelper.collectionStream(path: path, builder: (data) => Job.fromMap(data),);
  }
}