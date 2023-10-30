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

class ListaAdocoesAll extends StatelessWidget {
  final Function(String) modifyAdocoes;
  final bool filter_on;
  final bool isDono;
  final List<Adocao> adocoes;
  const ListaAdocoesAll(this.filter_on, this.isDono, this.adocoes, this.modifyAdocoes);

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(20),
      child: 
        adocoes.isEmpty
        ?               // a lista de adocoes esta vazia
          Container(
            alignment: Alignment.center,
            height: double.infinity,
            child:DefaultView(
              isDono 
              ?                              // é dono dos pets
                filter_on                         
                ? // Usuario esta filtrando a informação
                'Não há registros de adoção com esse filtro...'  
                : // Usuario esta tentando vê todas as informações                        
                'Seus pets não receberam pedidos de adoção no momento...'
              :                              // não é dono dos pets          
                filter_on                         
                ? // Usuario esta filtrando a informação
                'Você não está em processos de adoção com esse status...'  
                : // Usuario esta tentando vê todas as informações                                 
                'Você não está em processos de adoção no momento...'
            )
          )
        :               // a lista de adocoes não esta vazia
        Container(
          child: ListView.builder(
              itemCount: adocoes.length,
              itemBuilder: (context, index) {
                return AdocaoIcon(adocoes[index], isDono);
              },
          )    
        )
        
      );
  }
}
