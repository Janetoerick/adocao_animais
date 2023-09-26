import 'package:adocao_animais/components/default_view.dart';
import 'package:adocao_animais/screens/animal_detalhe_screen.dart';
import 'package:flutter/material.dart';
import '../data/my_data.dart';
import '../models/animal.dart'; // Certifique-se de importar o modelo Animal aqui

class TelaAnimaisFavoritados extends StatelessWidget {
  TelaAnimaisFavoritados({super.key});

  @override
  Widget build(BuildContext context) {
    final animaisFavoritados =
        animais.where((animal) => animal.isFavorito).toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Animais Favoritados'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: (animaisFavoritados.isEmpty)
          ? Center(
              child: DefaultView(
                "Você não tem animais favoritados no momento...",
              ),
            )
          : ListView.builder(
              itemCount: animaisFavoritados.length,
              itemBuilder: (ctx, index) {
                final animal = animaisFavoritados[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(
                          '/detalhe_screen',
                          arguments: animaisFavoritados[index],
                        )
                        .then((value) => null);
                  },
                  child: ListTile(
                    leading: Image.network(animal.img),
                    title: Text(animal.nome),
                    subtitle: Text(animal.tipo),
                    // Outros detalhes do animal podem ser adicionados aqui
                  ),
                );
              },
            ),
    );
  }
}
