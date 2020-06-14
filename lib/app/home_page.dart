import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/common_widgets/platform_alert_dialog.dart';
import 'package:time_tracker_flutter/services/auth_provider.dart';

class HomePage extends StatelessWidget {

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = AuthProvider.of(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
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
    );
  }
}
