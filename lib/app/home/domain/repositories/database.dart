
import 'package:time_tracker_flutter/app/home/domain/models/job.dart';

abstract class Database {

  Future<void> setJob(Job job);
  Stream<List<Job>> jobsStream();

}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();