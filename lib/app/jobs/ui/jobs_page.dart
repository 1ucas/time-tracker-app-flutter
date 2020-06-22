import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter/app/home/domain/repositories/database.dart';
import 'package:time_tracker_flutter/app/home/domain/models/job.dart';
import 'package:time_tracker_flutter/app/jobs/ui/edit_job_page.dart';
import 'package:time_tracker_flutter/app/jobs/ui/job_list_tile.dart';
import 'package:time_tracker_flutter/app/jobs/ui/list_item_builder.dart';
import 'package:time_tracker_flutter/common/domain/repositories/auth_repository.dart';
import 'package:time_tracker_flutter/common/ui/custom_widgets/platform_alert_dialog.dart';
import 'package:time_tracker_flutter/common/ui/custom_widgets/platform_exception_alert_dialog.dart';

class JobsPage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthRepository>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didSignOut = await PlatformAlertDialog(
      cancelActionText: 'Cancel',
      content: 'Are you sure you want to logout?',
      defaultActionText: "Logout",
      title: 'Logout',
    ).show(context);
    if (didSignOut == true) {
      _signOut(context);
    }
  }

  Future<void> _delete(BuildContext context, Job job) async {
    try {final database = Provider.of<Database>(context, listen: false);
    await database.deleteJob(job);
    } on PlatformException catch(e) {
      PlatformExceptionAlertDialog(
          exception: e,
          title: 'Operation Failed',
        ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jobs Page"),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Logout",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: () => _confirmSignOut(context),
          )
        ],
      ),
      body: _buildContents(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => EditJobPage.show(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<Job>>(
      stream: database.jobsStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Job>(
          snapshot: snapshot,
          itemBuilder: (context, job) => Dismissible(
            key: Key('job-${job.id}'),
            background: Container(
              color: Colors.red,
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _delete(context, job),
            child: JobListTile(
              job: job,
              onTap: () => EditJobPage.show(context, job: job),
            ),
          ),
        );
      },
    );
  }
}
