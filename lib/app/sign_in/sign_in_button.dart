import 'package:flutter/cupertino.dart';
import 'package:time_tracker_flutter/common_widgets/manobray_raised_button.dart';

class SignInButton extends ManobrayRaisedButton {
  SignInButton({
    @required String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  }) : assert(text != null),
  super(
    child: Text(text, style: TextStyle(color: textColor, fontSize: 15.0),),
    color: color,
    onPressed: onPressed,);
}