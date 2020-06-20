
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:time_tracker_flutter/app/home/data/api_path.dart';
import 'package:time_tracker_flutter/app/home/domain/repositories/database.dart';
import 'package:time_tracker_flutter/app/home/domain/models/job.dart';

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  final String uid;

  Future<void> createJob(Job job) async {
    final path = APIPath.job(uid, 'job_abc');
    final documentRef = Firestore.instance.document(path);
    await documentRef.setData(job.toMap());  
  }

}