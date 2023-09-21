import 'package:flutter/material.dart';

class AnimalPage extends StatelessWidget {
  const AnimalPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animal page"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
