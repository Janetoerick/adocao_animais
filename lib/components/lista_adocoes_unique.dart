import 'package:adocao_animais/components/adocao_icon.dart';
import 'package:adocao_animais/components/default_view.dart';
import 'package:adocao_animais/models/animal.dart';
import 'package:adocao_animais/repositories/adocoes_repository.dart';
import 'package:adocao_animais/repositories/usuario_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaAdocoesUnique extends StatefulWidget {
  final bool isDono;
  final Animal animal;
  const ListaAdocoesUnique(this.isDono, this.animal);

  @override
  State<ListaAdocoesUnique> createState() => _ListaAdocoesUniqueState();
}

class _ListaAdocoesUniqueState extends State<ListaAdocoesUnique> {
  @override
  Widget build(BuildContext context) {

    var usuario = context.watch<UsuarioRepository>().usuario;
    var repository = context.watch<AdocoesRepository>();

    var adocoes = [];
    
    adocoes.addAll(repository.findByAnimal(widget.animal));

    return Container(
      padding: EdgeInsets.all(20),
      child: 
        adocoes.isEmpty ?
          Container(
            alignment: Alignment.center,
            height: double.infinity,
            child:DefaultView(
              '${widget.animal.nome} não recebeu ainda pedidos de adoção...'
            )
          )
        :
        ListView.builder(
        itemCount: adocoes.length,
        itemBuilder: (context, index) {
          return AdocaoIcon(adocoes[index], widget.isDono);
        },
      ),
    );
  }
}