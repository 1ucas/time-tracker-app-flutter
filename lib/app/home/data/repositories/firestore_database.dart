import 'dart:async';
import 'package:meta/meta.dart';
import 'package:time_tracker_flutter/app/home/data/api_path.dart';
import 'package:time_tracker_flutter/app/home/data/repositories/firestore_helper.dart';
import 'package:time_tracker_flutter/app/home/domain/repositories/database.dart';
import 'package:time_tracker_flutter/app/home/domain/models/job.dart';
import 'package:time_tracker_flutter/app/job_entries/models/entry.dart';

// UseCase ???
class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  final String uid;

  final _firestoreHelper = FirestoreHelper.instance;

  @override
  Future<void> setJob(Job job) async {
    final path = APIPath.job(uid, job.id);
    await _firestoreHelper.setData(path: path, data: job.toMap());
  }

  @override
  Future<void> deleteJob(Job job) async {
    // Delete entries from job
    final allEntries = await entriesStream(job: job).first;
    for (Entry entry in allEntries) {
      if (entry.jobId == job.id) {
        await deleteEntry(entry);
      }
    }
    // Delete Job
    return await _firestoreHelper.deleteData(path: APIPath.job(uid, job.id));
  }

  @override
  Stream<Job> jobStream({@required String jobId}) =>
      _firestoreHelper.documentStream(
        path: APIPath.job(uid, jobId),
        builder: (data, documentId) => Job.fromMap(data, documentId),
      );

  @override
  Stream<List<Job>> jobsStream() {
    final path = APIPath.jobs(uid);
    return _firestoreHelper.collectionStream(
      path: path,
      builder: (data, documentId) => Job.fromMap(data, documentId),
    );
  }

  @override
  Future<void> setEntry(Entry entry) async => await _firestoreHelper.setData(
        path: APIPath.entry(uid, entry.id),
        data: entry.toMap(),
      );

  @override
  Future<void> deleteEntry(Entry entry) async =>
      await _firestoreHelper.deleteData(path: APIPath.entry(uid, entry.id));

  @override
  Stream<List<Entry>> entriesStream({Job job}) =>
      _firestoreHelper.collectionStream<Entry>(
        path: APIPath.entries(uid),
        queryBuilder: job != null
            ? (query) => query.where('jobId', isEqualTo: job.id)
            : null,
        builder: (data, documentID) => Entry.fromMap(data, documentID),
        sort: (lhs, rhs) => rhs.start.compareTo(lhs.start),
      );
}
