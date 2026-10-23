# Cadastro App

Tela de cadastro de usuário desenvolvida em Flutter, com validação de campos e feedback visual por SnackBar.

## Funcionalidades

- Campos: nome completo, e-mail, CPF, telefone, senha e confirmação de senha
- Todos os campos obrigatórios
- E-mail validado com `@` e RegExp
- Senha com no mínimo 6 caracteres e botão de mostrar/ocultar
- Confirmação de senha com checagem de igualdade
- CPF (limite de 11 dígitos) e telefone aceitam somente números
- Erros exibidos abaixo de cada campo inválido
- SnackBar verde no sucesso e vermelho quando há campos inválidos

## Estrutura da tela

```
Scaffold
└── Form
    └── SingleChildScrollView
        └── Column
            ├── TextFormField (nome)
            ├── TextFormField (e-mail)
            ├── TextFormField (CPF)
            ├── TextFormField (telefone)
            ├── TextFormField (senha)
            ├── TextFormField (confirmar senha)
            └── ElevatedButton (CADASTRAR)
```

## Como executar

```bash
git clone https://github.com/SEU_USUARIO/cadastro_app.git
cd cadastro_app
flutter pub get
flutter run
```

## Tecnologias

- Flutter
- Dart

## Autora

Caroline Xavier - 2312225
