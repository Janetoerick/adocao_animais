import 'package:adocao_animais/components/lista_adocoes.dart';
import 'package:adocao_animais/repositories/usuario_repository.dart';
import 'package:flutter/material.dart';
import 'package:adocao_animais/screens/login_screen.dart';
import 'package:adocao_animais/screens/cadastro_screen.dart';
import 'package:adocao_animais/models/usuario.dart';
import 'package:provider/provider.dart';

import '../components/default_view.dart';
import '../models/adocao.dart';
import '../models/animal.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UsuarioRepository>();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Adote Petz ", style: TextStyle(fontWeight: FontWeight.bold)),
            Icon(Icons.pets)
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        actions: [
          // Botão de acesso à tela de login
          //
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: TextButton(
              onPressed: () {
                if (user.usuario.login == '') {
                  Navigator.pushNamed(
                    context,
                    '/login',
                  );
                }
              },
              child: Row(
                children: [
                  SizedBox(width: 10),
                  (user.usuario.login != '')
                      ? Text("Olá, ${user.usuario!.nome}",
                          style: TextStyle(color: Colors.white))
                      : Text("Login", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
          // Botão de acesso à tela de cadastro
          // TextButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => CadastroScreen()),
          //     );
          //   },
          //   child: Text("Cadastro", style: TextStyle(color: Colors.white)),
          // ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text('Que tal adotar?',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold)),
                        Text(
                          'Diz que sim',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      'lib/assets/dog_and_cat.png',
                      width: 140,
                      height: 140,
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Animais em fase de adoção:',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            (user.adocoes.isEmpty)
                ? Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DefaultView(
                            'Você não está em processos de adoção no momento...'),
                      ],
                    ),
                  )
                : ListaAdocoes()
          ],
        ),
      ),
    );
  }
}
