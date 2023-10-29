import 'package:adocao_animais/components/lista_adocoes_all.dart';
import 'package:adocao_animais/components/lista_adocoes_unique.dart';
import 'package:adocao_animais/models/animal.dart';
import 'package:adocao_animais/repositories/adocoes_repository.dart';
import 'package:adocao_animais/repositories/usuario_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdocaoUniqueScreen extends StatelessWidget {
  const AdocaoUniqueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final animal = ModalRoute.of(context)?.settings.arguments as Animal;

    final user = context.watch<UsuarioRepository>().usuario;
    final repository = context.watch<AdocoesRepository>();

    bool isDono = false;
    if(repository.user_adocoes.isEmpty){
      isDono = true;
    } else {
      if(repository.user_adocoes[0].animal.dono.login == user.login){
        isDono = true;
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('Gerenciar adoções'),),
      body: ListaAdocoesUnique(isDono, animal),
    );
  }
}