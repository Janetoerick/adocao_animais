import 'package:adocao_animais/components/filtro_animais.dart';
import 'package:adocao_animais/components/lista_animais.dart';
import 'package:adocao_animais/repositories/animais_repository.dart';
import 'package:adocao_animais/screens/animal_favorito_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/default_view.dart';
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
        builder: (BuildContext context) {
          return FiltroAnimais(filter, _novo_filtro);
        });
  }

  _novo_filtro(String tipo) {
    if(tipo != ''){
      filter_on = true;
    } else {
      _remove_filter();
      return;
    }
    _animais_filter = [];

    final _total_animals = Provider.of<AnimaisRepository>(context, listen: false).animais;
    setState(() {
      if (tipo != '') {
        filter = tipo;
        _animais_filter.addAll(_total_animals.where((e) => e.tipo == tipo));
      } else {
        filter_on = false;
      }
    });
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
    final _total_animals = Provider.of<AnimaisRepository>(context, listen: false).animais;

    return Scaffold(
        appBar: AppBar(
          title: Text("Nossos peludos e penudos"),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        body: Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
              child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: !filter_on
                ? ListaAnimais(_total_animals)
                : !_animais_filter.isEmpty
                    ? ListaAnimais(_animais_filter)
                    : Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: DefaultView(
                              'Não há ${filter}s registrados no momento...'),
                        ),
                      ),
          ))
        ],
      ),
    ),
    floatingActionButton: ElevatedButton(
      style: ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50.0),
    )
  )
),
                onPressed: () => _openTaskFilterModal(context),
                child: Container(
                  height: 60,
                  width: 25,
                  alignment: Alignment.center,
                  child: Icon(Icons.filter_list),
              ),
    ));
  }
}
