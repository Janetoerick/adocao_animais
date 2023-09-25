import 'package:adocao_animais/main.dart';
import 'package:adocao_animais/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:adocao_animais/screens/cadastro_screen.dart';
import 'package:adocao_animais/models/usuario.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _loginController, // Captura o valor do campo de login
              decoration: InputDecoration(labelText: 'Login'),
            ),
            TextFormField(
              controller: _senhaController, // Captura o valor do campo de senha
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                // Obtém os valores digitados nos campos de login e senha
                final String login = _loginController.text;
                final String senha = _senhaController.text;

                // Chama a função fazerLogin para verificar as credenciais
                final Usuario? usuario =
                    GerenciadorUsuarios().fazerLogin(login, senha);

                if (usuario is UsuarioInvalido) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Credenciais inválidas. Verifique seu login e senha.'),
                    ),
                  );
                } else {
                  // Usuário logado com sucesso, faça a navegação para a próxima tela
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyApp(usuario: usuario),
                    ),
                  );
                }
              },
              child: Text('Entrar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CadastroScreen()),
                );
              },
              child: Text('Criar uma conta'),
            ),
          ],
        ),
      ),
    );
  }
}
