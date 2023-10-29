import 'package:adocao_animais/components/lista_adocoes_all.dart';
import 'package:adocao_animais/models/animal.dart';
import 'package:flutter/material.dart';

class AdocaoAllScreen extends StatelessWidget {
  const AdocaoAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDono = ModalRoute.of(context)?.settings.arguments as bool;


    return Scaffold(
      appBar: AppBar(title: Text('Gerenciar adoções'),),
      body: ListaAdocoesAll(isDono),
    );
  }
}