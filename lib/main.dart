import 'dart:math';

import 'package:adocao_animais/repositories/animais_repository.dart';
import 'package:adocao_animais/repositories/usuario_repository.dart';
import 'package:adocao_animais/screens/animal_detalhe_screen.dart';
import 'package:adocao_animais/screens/login_screen.dart';
import 'package:adocao_animais/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:adocao_animais/models/usuario.dart';

import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AnimaisRepository()),
        ChangeNotifierProvider(create: (context) => UsuarioRepository()),
      ],
      child: MaterialApp(
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
          '/': (ctx) => TabsScreen(),
          '/detalhe_screen': (ctx) =>
              AnimalDetalheScreen(),
          '/login': (ctx) =>
              LoginScreen(),
        },
      ),
    );
  }
}
