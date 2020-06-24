import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:time_tracker_flutter/app/sign_in/domain/models/email_sign_in_model.dart';
import 'package:time_tracker_flutter/app/sign_in/domain/use_cases/email_sign_in_bloc.dart';
import 'mocks_util.dart';

void main() {
  MockAuth mockAuth;
  EmailSignInBloc bloc;

  setUp(() {
    mockAuth = MockAuth();
    bloc = EmailSignInBloc(auth: mockAuth);
  });

  tearDown(() {
    bloc.dispose();
  });

  test(
      'WHEN email is updated '
      'AND password is updated '
      'AND Submit is called '
      'THEN modelStream emits the correct events', () async {
    // Cenário de Erro
    when(mockAuth.signInWithEmailAndPassword(any, any)).thenThrow(
      PlatformException(
        code: 'ERROR',
      ),
    );

    expect(
      bloc.modelStream,
      emitsInOrder( // Carrega todos os expect() de cada interação 
        [
          EmailSignInModel(), // Inicialização
          EmailSignInModel(email: 'email@email.com'), // updateEmail()
          EmailSignInModel(
            email: 'email@email.com',
            password: 'password',
          ), // updatePassword()
          EmailSignInModel(
            email: 'email@email.com',
            password: 'password',
            submitted: true,
            isLoading: true,
          ), // inicio do loading do Submit
          EmailSignInModel(
            email: 'email@email.com',
            password: 'password',
            submitted: true,
            isLoading: false,
          ), // fim do loading do Submit após erro
        ],
      ),
    );

    // Atualiza Email
    bloc.updateEmail('email@email.com');
    
    // Atualiza Password
    bloc.updatePassword('password');
    
    // Faz o login
    try {
      await bloc.submit();
    } catch (_) {}
  });
}
