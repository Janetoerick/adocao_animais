import 'dart:math';

import 'package:adocao_animais/repositories/adocoes_repository.dart';
import 'package:adocao_animais/repositories/animais_repository.dart';
import 'package:adocao_animais/repositories/usuario_repository.dart';
import 'package:adocao_animais/screens/adocao_detalhe_screen.dart';
import 'package:adocao_animais/screens/adocao_screen.dart';
import 'package:adocao_animais/screens/animal_detalhe_screen.dart';
import 'package:adocao_animais/screens/cadastro_screen.dart';
import 'package:adocao_animais/screens/form_animal_screen.dart';
import 'package:adocao_animais/screens/login_screen.dart';
import 'package:adocao_animais/screens/meus_animais_screen.dart';
import 'package:adocao_animais/screens/tabs_screen.dart';
import 'package:adocao_animais/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:adocao_animais/models/usuario.dart';

import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

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
        ChangeNotifierProvider(create: (context) => AdocoesRepository()),
      ],
      child: MaterialApp(
        title: 'Amigos de patas',
        theme: ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: Color(0xff0A3200),
                secondary: Color(0xff379634),
                tertiary: Color(0xff7CFFCB),
              ),
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        initialRoute: '/',
        routes: {
          AppRoutes.HOME: (ctx) => TabsScreen(),
          AppRoutes.ANIMAL_DETAIL: (ctx) => AnimalDetalheScreen(),
          AppRoutes.LOGIN: (ctx) => LoginScreen(),
          AppRoutes.CADASTRO_USER: (ctx) => CadastroScreen(),
          AppRoutes.FORM_ANIMAL: (ctx) => FormAnimalScreen(),
          AppRoutes.MEUS_PETS: (ctx) => MeusAnimaisScreen(),
          AppRoutes.ADOCAO: (ctx) => AdocaoScreen(),
          AppRoutes.ADOCAO_DETAIL: (ctx) => AdocaoDetalheScreen(),
        },
      ),
    );
  }
}
