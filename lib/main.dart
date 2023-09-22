import 'package:adocao_animais/screens/tabs_screen.dart';
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
              primary: Color(0xff0A3200),
              secondary: Color(0xff379634),
              tertiary: Color(0xff7CFFCB),
            ),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => const TabsScreen(),
      },
    );
  }
}
