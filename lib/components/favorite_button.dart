import 'package:adocao_animais/repositories/usuario_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/animal.dart';

class FavoriteButton extends StatelessWidget {
  final Animal animal;
  final Function(bool) onChanged;

  FavoriteButton({required this.animal, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UsuarioRepository>();

    return IconButton(
      icon: Icon(user.animaisFav.contains(animal) ? Icons.favorite : Icons.favorite_border),
      color: user.animaisFav.contains(animal) ? Colors.red : null,
      onPressed: () {
        user.attAnimalFav(animal).then((value) {
          if(!value) {
            showDialog(context: context, builder: (BuildContext context) =>
            AlertDialog(
              title: const Text('Requer login'),
              content: const Text('Para adicionar o animal nos seus favoritos você deve estar logado no sistema...'),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar'),),
                TextButton(onPressed: () {}, child: const Text('Fazer login'),)
              ],
            ));
          } else {
            onChanged(!animal.isFavorito);
          }
        });
        
      },
    );
  }
}
