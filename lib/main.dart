import 'package:adocao_animais/screens/home_page.dart';
import 'package:adocao_animais/utils/routes.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NOME PROVISÓRIO',
      theme: ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: Colors.black,
                secondary: Colors.white,
                tertiary: Colors.amber,
              ),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline1:
                  TextStyle(fontSize: 18, fontFamily: 'RobotoCondensed'))),
      initialRoute: '/',
      routes: {
        Routes.HOME: (ctx) => HomePage(),
      },
    );
  }
}
