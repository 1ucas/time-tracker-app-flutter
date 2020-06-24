import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter/app/sign_in/ui/selection_sign_in/sign_in_page.dart';
import 'package:time_tracker_flutter/common/domain/repositories/auth_repository.dart';
import 'mocks_util.dart';

void main() {
  MockAuth mockAuth;
  MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    mockAuth = MockAuth();
    mockNavigatorObserver = MockNavigatorObserver();
  });

  Future<void> pumpSignInPage(WidgetTester tester,
      {VoidCallback onSignedIn}) async {
    await tester.pumpWidget(
      Provider<AuthRepository>(
        create: (_) => mockAuth,
        child: MaterialApp(
          navigatorObservers: [mockNavigatorObserver],
          home: Builder(
            // Usado Builder para fornecer Context
            builder: (context) => SignInPage.create(context),
          ),
        ),
      ),
    );
    // Primeiro Push do Navigator para a Pagina SignInPage
    verify(mockNavigatorObserver.didPush(any, any)).called(1);
  }

  testWidgets('email and password navigation', (WidgetTester tester) async {
    await pumpSignInPage(tester);

    // Clicar no botão de login com email e password
    final emailButton = find.byKey(SignInPage.emailPasswordKey);
    expect(emailButton, findsOneWidget);
    await tester.tap(emailButton);

    // Realizar a Navegação
    await tester.pumpAndSettle();

    // Segundo Push do Navigator para a Pagina Email
    verify(mockNavigatorObserver.didPush(any, any)).called(1);
  });
}
