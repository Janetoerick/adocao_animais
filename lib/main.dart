import 'package:adocao_animais/screens/animal_detalhe_screen.dart';
import 'package:adocao_animais/screens/tabs_screen.dart';
import 'package:flutter/material.dart';

import 'models/animal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Animal> _AnimalAdotado = [];

  void _saveAdotado(Animal animal) {
    setState(() {
      _AnimalAdotado.contains(animal)
          ? _AnimalAdotado.remove(animal)
          : _AnimalAdotado.add(animal);
    });
  }

  bool _isAdotado(Animal animal) {
    return _AnimalAdotado.contains(animal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amigos de patas',
      theme: ThemeData(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Color(0xff0A3200),
              secondary: Color(0xff379634),
              tertiary: Color(0xff7CFFCB),
            ),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontSize: 18,
              ),
            ),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(_AnimalAdotado),
        '/detalhe_screen': (ctx) =>
            AnimalDetalheScreen(_saveAdotado, _isAdotado),
      },
    );
  }
}
