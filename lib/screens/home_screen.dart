import 'package:adocao_animais/components/grid_options_home.dart';
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
            child: 
            (user.usuario.login == '') ?
            TextButton(
              onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/login',
                  );
              },
              child: Text("Fazer login", style: TextStyle(color: Colors.white)),
            )
            :
          PopupMenuButton(
            child: Row(
                children: [
                  Icon(Icons.account_circle, color: Colors.white,),
                  SizedBox(width: 5,),
                  
                      Text("${user.usuario.nome}",
                          style: TextStyle(color: Colors.white))
                ],
              ),
            itemBuilder: ((context) => [
            PopupMenuItem(child: ListTile(
                        title: Row(
                          children: [
                            Icon(Icons.logout),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text('Logout'),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.pop(context);
                              Provider.of<UsuarioRepository>(
                                context,
                                listen: false,
                              ).logoutUsuario();
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Sessão finalizada!'),
                        duration: const Duration(seconds: 1),
                      ));
                        },
                      ),)
          ]))
          )
          ,
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
              height: 100,
              child: const GridOptionsHome()),
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
