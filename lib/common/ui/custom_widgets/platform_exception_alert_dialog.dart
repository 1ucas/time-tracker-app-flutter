import 'package:meta/meta.dart';
import 'package:flutter/services.dart';
import 'package:time_tracker_flutter/common/ui/custom_widgets/platform_alert_dialog.dart';

class PlatformExceptionAlertDialog extends PlatformAlertDialog {
  PlatformExceptionAlertDialog({
    @required String title,
    @required PlatformException exception,
  }) : super(
          title: title,
          content: _message(exception),
          defaultActionText: "OK",
        );

  static String _message(PlatformException exception) {
    return _errors[exception.code] ??  exception.message;
  }

  static Map<String, String> _errors = {
    'ERROR_WEAK_PASSWORD': 'Weak Password',
    'ERROR_INVALID_CREDENTIAL': 'Invalid Credentials',
    'ERROR_EMAIL_ALREADY_IN_USE': 'Email already in use',
    'ERROR_INVALID_EMAIL': 'Invalid Email',
    'ERROR_WRONG_PASSWORD': 'Wrong Password',
    'ERROR_USER_NOT_FOUND': 'User not Found',
    'ERROR_USER_DISABLED': 'User Disabled',
    'ERROR_TOO_MANY_REQUESTS': 'Ops: Try again later.',
    'ERROR_OPERATION_NOT_ALLOWED': 'Ops: Try again later.',
  };
}
