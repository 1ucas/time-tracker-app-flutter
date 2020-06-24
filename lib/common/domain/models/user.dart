import 'package:flutter/foundation.dart';

class User {
  User({
    this.photoURL,
    this.displayName,
    @required this.uid,
  });

  final String uid;
  final String photoURL;
  final String displayName;
}
