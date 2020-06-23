

import 'package:time_tracker_flutter/app/home/domain/models/job.dart';
import 'package:time_tracker_flutter/app/job_entries/models/entry.dart';

class EntryJob {
  EntryJob(this.entry, this.job);

  final Entry entry;
  final Job job;
}
