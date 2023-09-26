import 'package:adocao_animais/components/favorite_button.dart';
import 'package:flutter/material.dart';

import '../models/animal.dart';
import '../data/my_data.dart';

class AnimalDetalheScreen extends StatefulWidget {
  final Function(Animal) saveAdotar;
  final Function(Animal) isAdotado;
  const AnimalDetalheScreen(this.saveAdotar, this.isAdotado);
  
  @override
  State<AnimalDetalheScreen> createState() => _AnimalDetalheScreenState();
}

class _AnimalDetalheScreenState extends State<AnimalDetalheScreen> {
  @override
  Widget build(BuildContext context) {
    final animal = ModalRoute.of(context)?.settings.arguments == null
        ? animais[0] // Tava dando null quando atualizava a página
        : ModalRoute.of(context)!.settings.arguments as Animal;

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
                        animal.img,
                        fit: BoxFit.cover,
                        height: 200,
                      )),
                      FavoriteButton(
                animal: animal,
                onChanged: (bool isFavorito) {
                  setState(() {
                    animal.isFavorito = isFavorito;
                  });
                }),
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
                          Text('Contatos:',
                              style: Theme.of(context).textTheme.headline6),
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: ListView.builder(
                              padding: EdgeInsets.only(top: 5),
                              shrinkWrap: true,
                              itemCount: animal.contato.length,
                              itemBuilder: (context, index) {
                                return Text(
                                  animal.contato[index],
                                  style: TextStyle(fontSize: 18),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
          ElevatedButton(
            onPressed: widget.isAdotado(animal)
                ? null
                : () {
                    widget.saveAdotar(animal);
                    Navigator.of(context).pop();
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
