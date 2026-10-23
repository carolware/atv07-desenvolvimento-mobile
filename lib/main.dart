import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

const Color kPrimary = Color(0xFF4F46E5);
const Color kError = Color(0xFFDC2626);
const Color kSuccess = Color(0xFF16A34A);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cadastro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kPrimary),
        useMaterial3: true,
      ),
      home: const CadastroPage(),
    );
  }
}

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmaSenhaController = TextEditingController();

  bool _ocultarSenha = true;
  bool _ocultarConfirmacao = true;

  static final RegExp _emailRegex =
  RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$');

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _telefoneController.dispose();
    _senhaController.dispose();
    _confirmaSenhaController.dispose();
    super.dispose();
  }

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: color),
  );

  InputDecoration _decoration(String label, String hint, {Widget? suffix}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      suffixIcon: suffix,
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      enabledBorder: _border(Colors.grey.shade300),
      focusedBorder: _border(kPrimary),
      errorBorder: _border(kError),
      focusedErrorBorder: _border(kError),
      errorStyle: const TextStyle(color: kError, fontSize: 12),
    );
  }

  void _mostrarSnackBar(String mensagem, Color cor, IconData icone) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: cor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Row(
            children: [
              Icon(icone, color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Expanded(child: Text(mensagem)),
            ],
          ),
        ),
      );
  }

  void _cadastrar() {
    if (_formKey.currentState!.validate()) {
      _mostrarSnackBar(
        'Cadastro realizado com sucesso!',
        kSuccess,
        Icons.check_circle_outline,
      );
    } else {
      _mostrarSnackBar(
        'Corrija os campos destacados.',
        kError,
        Icons.error_outline,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Crie sua conta',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Preencha os dados abaixo para começar.',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _nomeController,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    decoration: _decoration('Nome completo', 'Seu nome'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _decoration('E-mail', 'voce@email.com'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Campo obrigatório';
                      }
                      if (!value.contains('@') ||
                          !_emailRegex.hasMatch(value.trim())) {
                        return 'Informe um e-mail válido (deve conter @)';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _cpfController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(11),
                    ],
                    decoration: _decoration('CPF', 'Somente números'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _telefoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration:
                    _decoration('Telefone', 'Somente números (com DDD)'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _senhaController,
                    obscureText: _ocultarSenha,
                    decoration: _decoration(
                      'Senha',
                      'Mínimo de 6 caracteres',
                      suffix: IconButton(
                        icon: Icon(
                          _ocultarSenha
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () =>
                            setState(() => _ocultarSenha = !_ocultarSenha),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      if (value.length < 6) {
                        return 'A senha deve ter no mínimo 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmaSenhaController,
                    obscureText: _ocultarConfirmacao,
                    decoration: _decoration(
                      'Confirmar senha',
                      'Repita a senha',
                      suffix: IconButton(
                        icon: Icon(
                          _ocultarConfirmacao
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () => setState(
                                () => _ocultarConfirmacao = !_ocultarConfirmacao),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      if (value != _senhaController.text) {
                        return 'As senhas não coincidem';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _cadastrar,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'CADASTRAR',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}