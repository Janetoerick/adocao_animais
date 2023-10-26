import 'package:adocao_animais/components/default_view.dart';
import 'package:adocao_animais/repositories/usuario_repository.dart';
import 'package:adocao_animais/screens/animal_detalhe_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/my_data.dart';
import '../models/animal.dart'; // Certifique-se de importar o modelo Animal aqui

class TelaAnimaisFavoritados extends StatelessWidget {
  TelaAnimaisFavoritados({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UsuarioRepository>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Seus Favoritados'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: (user.animaisFav.isEmpty)
          ? Center(
              child: DefaultView(
                "Você não tem animais favoritados no momento...",
              ),
            )
          : ListView.builder(
              itemCount: user.animaisFav.length,
              itemBuilder: (ctx, index) {
                final animal = user.animaisFav[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(
                          '/detalhe_screen',
                          arguments: user.animaisFav[index],
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
