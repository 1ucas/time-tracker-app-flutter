import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter/app/home/ui/home_page.dart';
import 'package:time_tracker_flutter/app/landing/ui/landing_page.dart';
import 'package:time_tracker_flutter/app/sign_in/ui/selection_sign_in/sign_in_page.dart';
import 'package:time_tracker_flutter/common/domain/models/user.dart';
import 'package:time_tracker_flutter/common/domain/repositories/auth_repository.dart';
import 'mocks_util.dart';


void main() {
  MockAuth mockAuth;
  StreamController<User> authStateController;

  setUp(() {
    mockAuth = MockAuth();
    authStateController = StreamController<User>();
  });

  tearDown(() {
    authStateController.close();
  });

  Future<void> pumpLandingPage(WidgetTester tester) async {
    await tester.pumpWidget(
      Provider<AuthRepository>(
        create: (_) => mockAuth,
        child: MaterialApp(
          home: LandingPage(),
        ),
      ),
    );

    // Widget pega o último valor após rebuild
    await tester.pump();
  }

  void stubOnAuthStateChanged(Iterable<User> onAuthStateChanged) {
    authStateController
        .addStream(Stream<User>.fromIterable(onAuthStateChanged));
    when(mockAuth.onAuthStateChanged).thenAnswer((_) {
      return authStateController.stream;
    });
  }

  testWidgets('stream waiting', (WidgetTester tester) async {
    stubOnAuthStateChanged([]);

    await pumpLandingPage(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('null user', (WidgetTester tester) async {
    stubOnAuthStateChanged([null]);

    await pumpLandingPage(tester);

    expect(find.byType(SignInPage), findsOneWidget);
  });

  testWidgets('Usuário presente', (WidgetTester tester) async {
    stubOnAuthStateChanged([
      User(uid: '123'),
    ]);

    await pumpLandingPage(tester);

    expect(find.byType(HomePage), findsOneWidget);
  });
}
