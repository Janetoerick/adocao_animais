import 'package:adocao_animais/repositories/animais_repository.dart';
import 'package:adocao_animais/repositories/usuario_repository.dart';
import 'package:adocao_animais/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/animal.dart';

class FavoriteButton extends StatefulWidget {
  final Animal animal;
  final double size;

  FavoriteButton({required this.animal, required this.size});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    var user = context.watch<UsuarioRepository>();
    var animalRep = context.watch<AnimaisRepository>();

    return IconButton(
      icon: Icon(user.isFavorito(widget.animal) ? Icons.favorite : Icons.favorite_border, size: widget.size,),
      color: user.isFavorito(widget.animal) ? Colors.red : null,
      onPressed: () {
        user.attAnimalFav(widget.animal).then((value) {
          if(!value) {
            showDialog(context: context, builder: (BuildContext context) =>
            AlertDialog(
              title: const Text('Requer login'),
              content: const Text('Para adicionar o animal nos seus favoritos você deve estar logado no sistema...'),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar'),),
                TextButton(onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed(AppRoutes.LOGIN);
                }, child: const Text('Fazer login'),)
              ],
            ));
          } else {
            animalRep.attFavorito(widget.animal, user.usuario);
          }
        });
        
      },
    );
  }
}
