import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker_flutter/app/sign_in/domain/models/validators.dart';

void main() {
  test('Non Empty String', () {
    final validator = NonEmptyStringValidator();
    expect(validator.isValid('test'), true);
  });


  test('Empty String', () {
    final validator = NonEmptyStringValidator();
    expect(validator.isValid(''), false);
  });

  test('Null String', () {
    final validator = NonEmptyStringValidator();
    expect(validator.isValid(null), false);
  });

}