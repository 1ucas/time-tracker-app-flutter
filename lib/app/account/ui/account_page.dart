import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter/common/domain/models/user.dart';
import 'package:time_tracker_flutter/common/domain/repositories/auth_repository.dart';
import 'package:time_tracker_flutter/common/ui/custom_widgets/avatar.dart';
import 'package:time_tracker_flutter/common/ui/custom_widgets/platform_alert_dialog.dart';

class AccountPage extends StatelessWidget {
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

  Widget _buildUserInfo(User user) {
    return Column(
      children: <Widget>[
        Avatar(
          photoUrl: user.photoURL,
          radius: 50,
        ),
        SizedBox(
          height: 8,
        ),
        if (user.displayName != null)
          Text(
            user.displayName,
            style: TextStyle(color: Colors.white),
          ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(130),
          child: _buildUserInfo(user),
        ),
      ),
    );
  }
}
