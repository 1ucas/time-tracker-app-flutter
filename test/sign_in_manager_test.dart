import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:time_tracker_flutter/app/sign_in/domain/use_cases/sign_in_manager.dart';
import 'package:time_tracker_flutter/common/domain/models/user.dart';

import 'mocks_util.dart';

class MockValueNotifier<T> extends ValueNotifier<T> {
  MockValueNotifier(T value) : super(value);

  List<T> values = [];

  @override
  set value(T newValue) {
    values.add(newValue);
    super.value = newValue;
  }
}

void main() {
  MockAuth mockAuth;
  SignInManager manager;
  MockValueNotifier<bool> isLoading;

  setUp(() {
    mockAuth = MockAuth();
    isLoading = MockValueNotifier(false);
    manager = SignInManager(auth: mockAuth, isLoading: isLoading);
  });

  test('Sign In - Sucesso', () async {
    when(mockAuth.signInAnonymously()).thenAnswer(
      (_) => Future.value(
        User(uid: '123'),
      ),
    );

    await manager.signInAnonymously();

    expect(isLoading.values, [true]);
  });

  test('Sign In - Erro', () async {
    when(mockAuth.signInAnonymously()).thenThrow(
      PlatformException(
        code: 'ERROR',
        message: 'Sign in failed.',
      ),
    );

    try {
      await manager.signInAnonymously();
    } catch (e) {
      expect(isLoading.values, [true, false]);
    }
  });
}
