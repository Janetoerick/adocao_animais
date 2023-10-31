import 'package:adocao_animais/components/filtro_adocoes.dart';
import 'package:adocao_animais/components/lista_adocoes_all.dart';
import 'package:adocao_animais/models/adocao.dart';
import 'package:adocao_animais/models/animal.dart';
import 'package:adocao_animais/repositories/adocoes_repository.dart';
import 'package:adocao_animais/repositories/usuario_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdocaoAllScreen extends StatefulWidget {
  const AdocaoAllScreen({super.key});

  @override
  State<AdocaoAllScreen> createState() => _AdocaoAllScreenState();
}

class _AdocaoAllScreenState extends State<AdocaoAllScreen> {
  
  bool filter_on = false;
  List<Adocao> adocoes_filter = [];

  @override
  Widget build(BuildContext context) {
    final isDono = ModalRoute.of(context)?.settings.arguments as bool;

    var repository = context.watch<AdocoesRepository>();

    List<Adocao> all_adocoes = [];
    
    if(isDono){
      all_adocoes = repository.dono_adocoes;
    } else {
      all_adocoes = repository.user_adocoes;
    }

    
    _modifyAdocoes(String filtro){
      if(filtro != 'Todos'){
        adocoes_filter.clear();
        setState(() {
          if(isDono){
            adocoes_filter = repository.dono_adocoes.where((element) => element.status == filtro).toList();
          } else {
            adocoes_filter = repository.user_adocoes.where((element) => element.status == filtro).toList();
          }
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
          ? ListaAdocoesAll(filter_on, isDono, adocoes_filter, _modifyAdocoes)
          : ListaAdocoesAll(filter_on, isDono, all_adocoes, _modifyAdocoes),
          ),
        ],
      ),
    );
  }
}