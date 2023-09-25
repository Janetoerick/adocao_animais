import 'package:flutter/material.dart';
import '../models/animal.dart';

class FavoriteButton extends StatelessWidget {
  final Animal animal;
  final Function(bool) onChanged;

  FavoriteButton({required this.animal, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(animal.isFavorito ? Icons.favorite : Icons.favorite_border),
      color: animal.isFavorito ? Colors.red : null,
      onPressed: () {
        onChanged(!animal.isFavorito);
      },
    );
  }
}
