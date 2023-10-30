import 'package:adocao_animais/components/adocao_icon.dart';
import 'package:adocao_animais/components/default_view.dart';
import 'package:adocao_animais/components/filtro_adocoes.dart';
import 'package:adocao_animais/repositories/adocoes_repository.dart';
import 'package:adocao_animais/repositories/usuario_repository.dart';
import 'package:adocao_animais/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/adocao.dart';
import '../models/animal.dart';

class ListaAdocoesAll extends StatefulWidget {
  final bool isDono;
  const ListaAdocoesAll(this.isDono);

  @override
  State<ListaAdocoesAll> createState() => _ListaAdocoesState();
}

class _ListaAdocoesState extends State<ListaAdocoesAll> {
  
  @override
  Widget build(BuildContext context) {
    var usuario = context.watch<UsuarioRepository>().usuario;
    var repository = context.watch<AdocoesRepository>();

    List<Adocao> all_adocoes = [];
    List<Adocao> adocoes = [];
    
    if(widget.isDono){
      all_adocoes.addAll(repository.dono_adocoes);
    } else {
      all_adocoes.addAll(repository.user_adocoes);
    }

    adocoes = all_adocoes;

    _setFiltro(filtro){
      

      final new_list = repository.findByStatus(filtro, widget.isDono);
      setState((){
        print('entrou');
        adocoes = [];
        // if(filtro == 'Todos'){
        //   adocoes.addAll(all_adocoes);
        // } else {
        //   adocoes.addAll(new_list);
        // }
      }
      );
    }

    return Container(
      padding: EdgeInsets.all(20),
      child: 
        adocoes.isEmpty 
        ?
          widget.isDono 
          ?
          Container(
            alignment: Alignment.center,
            height: double.infinity,
            child:DefaultView(
              'Seus pets não receberam pedidos de adoção no momento...'
            )
          )
          :
          Container(
            alignment: Alignment.center,
            height: double.infinity,
            child:DefaultView(
              'Você não está em nenhum processo de adoção no momento...'
            )
          )
        :
        Expanded(
          child: Container(
            child: ListView.builder(
                itemCount: adocoes.length,
                itemBuilder: (context, index) {
                  return AdocaoIcon(adocoes[index], widget.isDono);
                },
            )    
          ),
        )
        
      );
  }
}
