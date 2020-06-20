import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter/app/landing/ui/landing_page.dart';
import 'package:time_tracker_flutter/common/data/repositories/firebase_auth_repository.dart';
import 'package:time_tracker_flutter/common/domain/repositories/auth_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthRepository>(
      create: (context) => FirebaseAuthRepository(),
      child: MaterialApp(
        title: 'Time Tracket',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: LandingPage(),
      ),
    );
  }
}
