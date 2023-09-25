import 'package:flutter/material.dart';

import '../models/animal.dart';

class HomeScreen extends StatelessWidget {
  final List<Animal> favoriteAnimals;
  const HomeScreen(this.favoriteAnimals);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home page"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
