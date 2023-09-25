import 'package:adocao_animais/components/filtro_animais.dart';
import 'package:adocao_animais/components/lista_animais.dart';
import 'package:flutter/material.dart';

import '../components/filter_view.dart';
import '../models/animal.dart';

import '../data/my_data.dart';

class AnimalPage extends StatefulWidget {
  @override
  State<AnimalPage> createState() => _AnimalPageState();
}

class _AnimalPageState extends State<AnimalPage> {
  List<Animal> _animais_filter = [];
  bool filter_on = false;
  String filter = '';

  _openTaskFilterModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return FiltroAnimais(_novo_filtro);
        });
  }

  _novo_filtro(String tipo) {
    filter_on = true;
    _animais_filter = [];
    setState(() {
      if (tipo != '') {
        filter = tipo;
        _animais_filter.addAll(animais.where((e) => e.tipo == tipo));
      } else {
        filter_on = false;
      }
    });

    Navigator.of(context).pop();
  }

  _remove_filter() {
    setState(() {
      filter = '';
      filter_on = false;
      _animais_filter = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("Animal page"),
        //   centerTitle: true,
        //   backgroundColor: Theme.of(context).colorScheme.secondary,
        // ),
        body: Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (filter_on) ? FilterView(filter, _remove_filter) : Container(),
              IconButton(
                onPressed: () => _openTaskFilterModal(context),
                icon: Icon(Icons.filter_list),
              )
            ],
          ),
          Expanded(
              child: SizedBox(
            child: !filter_on
                ? ListaAnimais(animais)
                : !_animais_filter.isEmpty
                    ? ListaAnimais(_animais_filter)
                    : Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Container(
                            child: Text(
                              "Não há esses animais registrados no momento...",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                        ),
                      ),
          ))
        ],
      ),
    ));
  }
}
