import 'package:flutter/material.dart';
import '../models/animal.dart'; // Certifique-se de importar o modelo Animal aqui

class TelaAnimaisFavoritados extends StatelessWidget {
  final List<Animal> animais;

  TelaAnimaisFavoritados(this.animais);

  @override
  Widget build(BuildContext context) {
    final animaisFavoritados =
        animais.where((animal) => animal.isFavorito).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Animais Favoritados'),
      ),
      body: ListView.builder(
        itemCount: animaisFavoritados.length,
        itemBuilder: (ctx, index) {
          final animal = animaisFavoritados[index];
          return ListTile(
            leading: Image.network(animal.img),
            title: Text(animal.nome),
            subtitle: Text(animal.tipo),
            // Outros detalhes do animal podem ser adicionados aqui
          );
        },
      ),
    );
  }
}
