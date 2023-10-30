import 'package:adocao_animais/components/default_view.dart';
import 'package:adocao_animais/components/lista_animais.dart';
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
          : Consumer<UsuarioRepository>(
            builder: (context, usuario, child) {
              return ListaAnimais(user.animaisFav, false);
            },
          ),
    );
  }
}
