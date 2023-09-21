import 'package:flutter/material.dart';

class AbrigoPage extends StatelessWidget {
  const AbrigoPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Abrigo page"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
