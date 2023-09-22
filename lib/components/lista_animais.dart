import 'package:adocao_animais/models/animal.dart';
import 'package:flutter/material.dart';

class ListaAnimais extends StatelessWidget {
  final List<Animal> animais;

  const ListaAnimais(this.animais);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: animais.length,
      itemBuilder: (ctx, index) {
        return Container(
          height: 100,
          color: Color(0x1f8a8a8a),
          child: Center(child: Text(animais[index].nome)),
        );
      },
    );
  }
}
