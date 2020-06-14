import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/app/landing_page.dart';
import 'package:time_tracker_flutter/services/auth.dart';
import 'package:time_tracker_flutter/services/auth_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
        title: 'Time Tracket',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: LandingPage(),
      ),
    );
  }
}
