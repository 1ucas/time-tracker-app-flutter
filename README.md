![Build](https://github.com/1ucas/time-tracker-app-flutter/workflows/Flutter-CI/badge.svg)

# Time Tracker Flutter

Aplicativo de Log de hora escrito em Dart.

### Disclaimer

Esse app tem uma mistura maluca de conceitos: usando BLOC (na mão), Repository Pattern, UseCase (fake). 

Use apenas para consulta.

### Para Buildar

1. Crie um projeto no Firebase (é 0800)
1. Baixe o arquivo google-services.json e inclua na pasta: ```android/app```
1. No console do Firebase vá em: Develop -> Authentication -> Sign-in Methods
1. Habilite as autenticações: Email, Google, Anonymous
1. Ainda no "Sign-in Methods" inclua como Authorized Domains a sua URL do firebase (xxxxxx.firebaseapp.com)

