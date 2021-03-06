import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:time_tracker_flutter/common/ui/custom_widgets/manobray_raised_button.dart';

class FormSubmitButton extends ManobrayRaisedButton {
  FormSubmitButton({
    @required String text,
    VoidCallback onPressed,
  }) : super(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            height: 44.0,
            color: Colors.indigo,
            borderRadius: 4.0,
            onPressed: onPressed);
}
