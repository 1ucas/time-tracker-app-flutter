
import 'package:time_tracker_flutter/app/home/domain/models/job.dart';

abstract class Database {

  Future<void> createJob(Job job);
  Stream<List<Job>> jobsStream();
  
}