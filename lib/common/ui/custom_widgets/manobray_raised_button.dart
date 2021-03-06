import 'package:flutter/material.dart';

class ManobrayRaisedButton extends StatelessWidget {
  ManobrayRaisedButton({
    Key key,
    this.child,
    this.color,
    this.borderRadius: 2.0,
    this.height: 50,
    this.onPressed,
  }) : assert(borderRadius != null), super(key: key);

  final Widget child;
  final Color color;
  final double borderRadius;
  final double height;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(
        child: child,
        color: color,
        disabledColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
