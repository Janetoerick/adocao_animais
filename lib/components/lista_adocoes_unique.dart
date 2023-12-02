import 'package:adocao_animais/components/adocao_icon.dart';
import 'package:adocao_animais/components/default_view.dart';
import 'package:adocao_animais/models/adocao.dart';
import 'package:adocao_animais/models/animal.dart';
import 'package:adocao_animais/repositories/adocoes_repository.dart';
import 'package:adocao_animais/repositories/usuario_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaAdocoesUnique extends StatelessWidget {
  final bool isDono;
  final Animal animal;
  final List<Adocao> adocoes;
  final bool filter_on;
  const ListaAdocoesUnique(
      this.isDono, this.animal, this.adocoes, this.filter_on);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: adocoes.isEmpty
          ? Container(
              alignment: Alignment.center,
              height: double.infinity,
              child: DefaultView(filter_on
                  ? '${animal.nome} não está com processos de adoção nesse status...'
                  : '${animal.nome} não recebeu pedidos de adoção ainda...'))
          : ListView.builder(
              itemCount: adocoes.length,
              itemBuilder: (context, index) {
                return AdocaoIcon(adocoes[index], isDono);
              },
            ),
    );
  }
}
