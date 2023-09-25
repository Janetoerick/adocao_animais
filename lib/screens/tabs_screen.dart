import 'package:adocao_animais/screens/animal_screen.dart';
import 'package:flutter/material.dart';

import 'package:adocao_animais/models/usuario.dart';
import 'home_screen.dart';

class TabsScreen extends StatefulWidget {
  final Usuario? usuario;

  const TabsScreen({Key? key, this.usuario}) : super(key: key);

  @override
  State<TabsScreen> createState() => _HomePageState();
}

class _HomePageState extends State<TabsScreen> {
  int paginaAtual = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        children: [
          HomeScreen(
              usuario: widget.usuario), // Passe o usuário para HomeScreen
          AnimalPage(),
        ],
        onPageChanged: setPaginaAtual,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'Animais'),
        ],
        onTap: (pagina) {
          pc.animateToPage(pagina,
              duration: Duration(milliseconds: 400), curve: Curves.ease);
        },
      ),
    );
  }
}
