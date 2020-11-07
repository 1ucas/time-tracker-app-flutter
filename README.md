![Build](https://github.com/1ucas/time-tracker-app-flutter/workflows/Flutter-CI/badge.svg)

# Time Tracker Flutter

Aplicativo de Log de hora escrito em Dart.

### Disclaimer

Esse app tem uma mistura maluca de conceitos: usando BLOC (na mão), Repository Pattern, UseCase (fake). 

Use apenas para consulta.

### Para Buildar

#### Configuração da app no firebase
1. Crie um projeto no Firebase (é 0800)
1. Adicione um app Android
  1. ProjectOverview (engrenagem) -> Project Settings - Your apps -> Add App
  1. Apenas para funcionar o Google Sign-In é necessário incluir a chave SHA-1 de seu keystore.debug
  1. Para gerar a chave SHA-1 vá em -> android / app -> e rode comando: ```./gradlew signingReport```
1. Baixe o arquivo google-services.json e inclua na pasta: android/app 

#### Configuração da autenticação
1. No console do Firebase vá em: Develop -> Authentication -> Sign-in Methods
1. Habilite as autenticações: Email, Google, Anonymous
1. (Se necessário) Ainda no "Sign-in Methods" inclua como Authorized Domains a sua URL do firebase (xxxxxx.firebaseapp.com)
1. Na aba Users / Usuários, crie um usuário de teste para autenticação via email

#### Configuração da app na IDE

1. Clone o repositório 
1. Na pasta raiz, digite os comandos
  1. ``` flutter pub get ````
  1. ``` flutter clean ```
  1. ``` flutter run -v ```  a opção -v é opcional para ver mais detalhes