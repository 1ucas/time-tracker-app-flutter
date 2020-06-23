import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({Key key, this.photoUrl, @required this.radius})
      : super(key: key);

  final String photoUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    // Use the Icon if the PhotoURL is Null
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.black12,
      backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
      child: photoUrl == null ? Icon(Icons.camera_alt, size: radius) : null,
    );
  }
}