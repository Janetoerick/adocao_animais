import 'package:adocao_animais/components/favorite_button.dart';
import 'package:adocao_animais/models/usuario.dart';
import 'package:adocao_animais/repositories/usuario_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/animal.dart';
import '../data/my_data.dart';

class AnimalDetalheScreen extends StatefulWidget {
  const AnimalDetalheScreen();

  @override
  State<AnimalDetalheScreen> createState() => _AnimalDetalheScreenState();
}

class _AnimalDetalheScreenState extends State<AnimalDetalheScreen> {

  @override
  Widget build(BuildContext context) {
    
    final animal = ModalRoute.of(context)?.settings.arguments == null
        ? animaisData[0] // Tava dando null quando atualizava a página
        : ModalRoute.of(context)!.settings.arguments as Animal;
    
    var usuario = context.watch<UsuarioRepository>();

    Usuario? user_animal;
    Provider.of<UsuarioRepository>(context).findByLogin(animal.dono).then((value) => user_animal = value);

    return Scaffold(
      appBar: AppBar(
        title: Text(animal.nome), // Nome do animal como título da página
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.81,
            child: SingleChildScrollView(
              child: Column(children: [
                Stack(children: [
                  Container(
                      color: Theme.of(context).colorScheme.secondary,
                      alignment: Alignment.center,
                      child: Image.network(
                        animal.img[0],
                        fit: BoxFit.cover,
                        height: 200,
                      )),
                  Positioned(
                    top: 10,
                    right: 30,
                    child: FavoriteButton(
                        animal: animal,
                        onChanged: (bool isFavorito) {
                          setState(() {
                            animal.isFavorito = isFavorito;
                          });
                        }),
                  ),
                  (animal.novo)
                      ? Positioned(
                          top: 10,
                          left: 30,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                            width: 50,
                            alignment: Alignment.center,
                            child: Text(
                              "Novo",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      : Container()
                ]), // Foto do animal
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Porte: ${animal.porte}',
                              style: Theme.of(context).textTheme.headline6),
                          Text('Sexo: ${animal.sexo}',
                              style: Theme.of(context).textTheme.headline6),
                          Text('Idade: ${animal.idade}',
                              style: Theme.of(context).textTheme.headline6),
                          Text('Raça: ${animal.raca}',
                              style: Theme.of(context).textTheme.headline6),
                          Text('Descrição: ${animal.descricao}',
                              style: Theme.of(context).textTheme.headline6),
                          Text('Telefone: ${user_animal!.telefone}',
                              style: Theme.of(context).textTheme.headline6),
                          Text('Email: ${user_animal!.email}',
                              style: Theme.of(context).textTheme.headline6),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
          ElevatedButton(
            onPressed: usuario.isAdotado(animal)
                ? null
                : () {
                    usuario.attAdocoes(animal).then((value) {
                      if(!value) {
            showDialog(context: context, builder: (BuildContext context) =>
            AlertDialog(
              
              title: const Text('Requer login'),
              content: const Text('Para adotar um animal você deve estar logado no sistema...'),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar'),),
                TextButton(onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed('/login');
                }, child: const Text('Fazer login'),)
              ],
            ));
          } else {
            Navigator.of(context).pop();
          }
                    });
                  },
            child: SizedBox(
              width: 200,
              height: 50,
              child: Center(
                child: Text(
                  "Adotar",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
