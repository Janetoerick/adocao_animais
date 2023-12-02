import 'package:adocao_animais/components/animal_icon.dart';
import 'package:adocao_animais/repositories/animais_repository.dart';
import 'package:flutter/material.dart';
import 'package:adocao_animais/models/animal.dart';
import 'package:adocao_animais/screens/animal_detalhe_screen.dart';
import 'package:provider/provider.dart';

class ListaAnimais extends StatelessWidget {
  final List<Animal> animais;
  final bool gerenciar;
  const ListaAnimais(this.animais, this.gerenciar);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: animais.length,
      itemBuilder: (ctx, index) {
        return AnimalIcon(animais[index], gerenciar);
      },
    );
  }
}
