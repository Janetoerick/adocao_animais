import 'package:adocao_animais/components/filtro_adocoes.dart';
import 'package:adocao_animais/components/lista_adocoes_all.dart';
import 'package:adocao_animais/components/lista_adocoes_unique.dart';
import 'package:adocao_animais/models/adocao.dart';
import 'package:adocao_animais/models/animal.dart';
import 'package:adocao_animais/repositories/adocoes_repository.dart';
import 'package:adocao_animais/repositories/usuario_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdocaoUniqueScreen extends StatefulWidget {
  const AdocaoUniqueScreen({super.key});

  @override
  State<AdocaoUniqueScreen> createState() => _AdocaoUniqueScreenState();
}

class _AdocaoUniqueScreenState extends State<AdocaoUniqueScreen> {

  bool filter_on = false;
  List<Adocao> adocoes_filter = [];
  
  @override
  Widget build(BuildContext context) {
    final animal = ModalRoute.of(context)?.settings.arguments as Animal;

    var repository = context.watch<AdocoesRepository>();

    List<Adocao> all_adocoes = [];
    
    all_adocoes.addAll(repository.findByAnimal(animal));
    
    _modifyAdocoes(String filtro){
      if(filtro != 'Todos'){
        adocoes_filter.clear();
        setState(() {
          adocoes_filter.addAll(repository.findByAnimal(animal).where((element) => element.status == filtro));
          filter_on = true;  
        });
      } else {
        setState(() {
          filter_on = false;  
        });
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('Gerenciar adoções'),),
      body: Column(
        children: [
          FiltroAdocoes(_modifyAdocoes),
          Expanded(child: 
          filter_on 
          ? ListaAdocoesUnique(true, animal, adocoes_filter, _modifyAdocoes, filter_on)
          : ListaAdocoesUnique(true, animal, all_adocoes, _modifyAdocoes, filter_on),
          ),
        ],
      ),
      
    );
  }
}