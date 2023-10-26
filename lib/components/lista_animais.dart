import 'package:adocao_animais/components/animal_icon.dart';
import 'package:adocao_animais/repositories/animais_repository.dart';
import 'package:flutter/material.dart';
import 'package:adocao_animais/models/animal.dart';
import 'package:adocao_animais/screens/animal_detalhe_screen.dart';
import 'package:provider/provider.dart';

class ListaAnimais extends StatelessWidget {

  const ListaAnimais();

  @override
  Widget build(BuildContext context) {

    return Consumer<AnimaisRepository>(
      builder: (context, animal, child) { 
        return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: animal.animais.length,
        itemBuilder: (ctx, index) {
          return AnimalIcon(animal.animais[index]);
        },
            );
  });
  }
}
