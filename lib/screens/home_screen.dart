import 'package:flutter/material.dart';
import 'package:adocao_animais/screens/login_screen.dart';
import 'package:adocao_animais/screens/cadastro_screen.dart';
import 'package:adocao_animais/models/usuario.dart';

class HomeScreen extends StatelessWidget {
  final Usuario? usuario;

  const HomeScreen({Key? key, this.usuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home page"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        actions: [
          // Botão de acesso à tela de login
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: Row(
              children: [
                if (usuario !=
                    null) // Exibe o nome do usuário se estiver logado
                  SizedBox(width: 10),
                if (usuario != null)
                  Text("Olá, ${usuario!.nome}",
                      style: TextStyle(color: Colors.white)),
                SizedBox(width: 10),
                Text("Login", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          // Botão de acesso à tela de cadastro
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CadastroScreen()),
              );
            },
            child: Text("Cadastro", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
