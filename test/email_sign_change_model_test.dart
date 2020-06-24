import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker_flutter/app/sign_in/domain/models/email_sign_in_change_model.dart';
import 'mocks_util.dart';

void main() {
  MockAuth mockAuth;
  EmailSignInChangeModel model;

  setUp(() {
    mockAuth = MockAuth();
    model = EmailSignInChangeModel(auth: mockAuth);
  });

  test('update email', () {
    // Teste de Change Notifier usando listener mock
    var didNotifyListeners = false;
    
    model.addListener(() {
      didNotifyListeners = true;
    });

    const email = 'email@email.com';
    model.updateEmail(email);

    expect(model.email, email);
    expect(didNotifyListeners, true);
  });
}
