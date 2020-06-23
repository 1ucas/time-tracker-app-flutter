import 'package:flutter/foundation.dart';

class User {
  User({@required this.photoURL, @required this.displayName, @required this.uid});

  final String uid;
  final String photoURL;
  final String displayName;
}