import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/common/ui/custom_widgets/manobray_raised_button.dart';

class SocialSignInButton extends ManobrayRaisedButton {
  SocialSignInButton({
    @required String assetName,
    @required String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  })  : assert(assetName != null),
        assert(text != null),
        super(
          child: Row(
            children: <Widget>[
              Image.asset(assetName),
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 15.0,
                ),
              ),
              Opacity(
                opacity: 0,
                child: Image.asset(assetName),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          color: color,
          onPressed: onPressed,
        );
}
