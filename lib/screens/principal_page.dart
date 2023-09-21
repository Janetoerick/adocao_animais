import 'package:flutter/material.dart';

class PrincipalPage extends StatelessWidget {
  const PrincipalPage({super.key});
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
