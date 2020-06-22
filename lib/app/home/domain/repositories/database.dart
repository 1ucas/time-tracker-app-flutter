
import 'package:meta/meta.dart';
import 'package:time_tracker_flutter/app/home/domain/models/job.dart';
import 'package:time_tracker_flutter/app/job_entries/models/entry.dart';

abstract class Database {

  Future<void> setJob(Job job);
  Future<void> deleteJob(Job job);
  Stream<List<Job>> jobsStream();
  Stream<Job> jobStream({@required String jobId});

  Future<void> setEntry(Entry entry);
  Future<void> deleteEntry(Entry entry);
  Stream<List<Entry>> entriesStream({Job job});

}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();