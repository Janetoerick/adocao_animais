import 'package:adocao_animais/components/filtro_animais.dart';
import 'package:adocao_animais/components/lista_animais.dart';
import 'package:flutter/material.dart';

import '../models/animal.dart';

class AnimalPage extends StatefulWidget {
  const AnimalPage({super.key});

  @override
  State<AnimalPage> createState() => _AnimalPageState();
}

class _AnimalPageState extends State<AnimalPage> {
  List<Animal> _animais = [
    Animal(
        id: 'l01',
        tipo: 'gato',
        nome: 'Felix o gato',
        idade: 2,
        raca: 'falino',
        descricao: 'Branco om manchas pretas'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Animal page"),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              FiltroAnimais(),
              Expanded(
                child: SizedBox(
                  child: ListaAnimais(_animais),
                ),
              )
            ],
          ),
        ));
  }
}
