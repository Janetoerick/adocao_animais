import 'package:adocao_animais/components/default_view.dart';
import 'package:adocao_animais/components/lista_animais.dart';
import 'package:adocao_animais/models/animal.dart';
import 'package:adocao_animais/repositories/animais_repository.dart';
import 'package:adocao_animais/repositories/usuario_repository.dart';
import 'package:adocao_animais/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MeusAnimaisScreen extends StatefulWidget {
  const MeusAnimaisScreen({super.key});

  @override
  State<MeusAnimaisScreen> createState() => _MeusAnimaisScreenState();
}

class _MeusAnimaisScreenState extends State<MeusAnimaisScreen> {
  @override
  Widget build(BuildContext context) {
    var animais = Provider.of<UsuarioRepository>(context).meus_animais;

    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Pets'),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.FORM_ANIMAL);
          }, icon: Icon(Icons.add))
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.85,
        child: 
        animais.isEmpty ?
        Container(alignment: Alignment.center,child: DefaultView('Você não tem animais cadastrado no momento...'))
        :
        ListaAnimais(animais, true)
      ),
      bottomSheet: 
      animais.isEmpty ?
      Container(height: 0,)
      :
      Container(
        height: MediaQuery.of(context).size.height * 0.055,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.ADOCAO_ALL, arguments: true);
          }, 
          child: Text('Gerenciar processos de adoção', style: TextStyle(fontSize: 18),)),
      ),

    );
  }
}