import 'package:adocao_animais/screens/animal_screen.dart';
import 'package:flutter/material.dart';

import '../models/adocao.dart';
import '../models/animal.dart';
import 'home_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Adocao> adocoes;
  final Function(Animal) onSubmit;
  const TabsScreen(this.adocoes, this.onSubmit);

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
          HomeScreen(widget.adocoes, widget.onSubmit),
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
