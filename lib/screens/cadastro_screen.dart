import 'package:flutter/material.dart';
import 'package:adocao_animais/models/usuario.dart';

class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  // Função para verificar se todos os campos estão preenchidos
  bool _todosCamposPreenchidos() {
    return _nomeController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _telefoneController.text.isNotEmpty &&
        _cpfController.text.isNotEmpty &&
        _loginController.text.isNotEmpty &&
        _senhaController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _telefoneController,
              decoration: InputDecoration(labelText: 'Telefone'),
            ),
            TextFormField(
              controller: _cpfController,
              decoration: InputDecoration(labelText: 'CPF'),
            ),
            TextFormField(
              controller: _loginController,
              decoration: InputDecoration(labelText: 'Login'),
            ),
            TextFormField(
              controller: _senhaController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                if (_todosCamposPreenchidos()) {
                  // Todos os campos estão preenchidos, cadastre o usuário
                  final novoUsuario = Usuario(
                    id: DateTime.now().toString(),
                    nome: _nomeController.text,
                    email: _emailController.text,
                    telefone: _telefoneController.text,
                    cpf: _cpfController.text,
                    login: _loginController.text,
                    senha: _senhaController.text,
                  );

                  // Adicione o novo usuário à lista de usuários
                  GerenciadorUsuarios().cadastrarNovoUsuario(novoUsuario);

                  // Limpe os campos após o cadastro
                  _nomeController.clear();
                  _emailController.clear();
                  _telefoneController.clear();
                  _cpfController.clear();
                  _loginController.clear();
                  _senhaController.clear();

                  // Exiba uma mensagem de sucesso
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Cadastro realizado com sucesso!'),
                    ),
                  );
                } else {
                  // Alguns campos estão vazios, exiba uma mensagem de erro
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Alguns campos estão vazios ou incorretos.'),
                    ),
                  );
                }
              },
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
