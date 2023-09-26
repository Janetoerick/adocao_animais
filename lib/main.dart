import 'dart:math';

import 'package:adocao_animais/screens/animal_detalhe_screen.dart';
import 'package:adocao_animais/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:adocao_animais/models/usuario.dart';

import 'models/adocao.dart';
import 'models/animal.dart';
import 'models/usuario.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  final Usuario? usuario;

  const MyApp({Key? key, this.usuario}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Animal> _AnimalAdotado = [];
  List<Adocao> _adocoes = [];

  void _saveAdotado(Animal animal) {
    setState(() {
      if (_AnimalAdotado.contains(animal)) {
        _AnimalAdotado.remove(animal);
        _adocoes.removeWhere((element) => element.animal == animal);
      } else {
        _AnimalAdotado.add(animal);
        _adocoes.add(Adocao(
          id: Random().toString(),
          animal: animal,
          status: 'em processo...',
          usuario: Usuario(
              id: '123',
              email: 'janeto@gmail.com',
              cpf: '92942842828',
              nome: 'janeto',
              telefone: '994124664',
              login: 'jan',
              senha: '123'),
          data: DateTime.now(),
        ));
      }
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
        '/': (ctx) => TabsScreen(widget.usuario, _adocoes, _saveAdotado),
        '/detalhe_screen': (ctx) =>
            AnimalDetalheScreen(_saveAdotado, _isAdotado),
      },
    );
  }
}
