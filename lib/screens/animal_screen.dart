import 'package:adocao_animais/components/filtro_animais.dart';
import 'package:adocao_animais/components/lista_animais.dart';
import 'package:flutter/material.dart';

import '../components/filter_view.dart';
import '../models/animal.dart';

class AnimalPage extends StatefulWidget {
  const AnimalPage({super.key});

  @override
  State<AnimalPage> createState() => _AnimalPageState();
}

class _AnimalPageState extends State<AnimalPage> {
  List<Animal> _animais = [
    Animal(
      id: 'l01',
      novo: true,
      tipo: 'Gato',
      nome: 'Felix o gato',
      sexo: 'Macho',
      porte: 'Pequeno',
      idade: '4 meses',
      img:
          'https://veterinariadavinci.com.br/blog/wp-content/uploads/2017/05/os-cuidados-com-filhotes-de-gatos.jpg',
      raca: 'falino',
      descricao: 'Branco om manchas pretas',
      contato: '994412255',
      data_registro: DateTime.now(),
    ),
    Animal(
      id: 'l02',
      novo: false,
      tipo: 'Cachorro',
      nome: 'Au o cão',
      sexo: 'Femea',
      porte: 'Medio',
      idade: '1 ano e 2 meses',
      img:
          'https://t1.ea.ltmcdn.com/pt/posts/4/2/8/pedigree_de_cachorro_o_que_e_e_como_fazer_1824_600.jpg',
      raca: 'Golden',
      descricao: 'Peludo',
      contato: '994455525',
      data_registro: DateTime.now(),
    ),
    Animal(
      id: 'l03',
      novo: false,
      tipo: 'Gato',
      nome: 'Antonio Gebedaia',
      sexo: 'Macho',
      porte: 'Pequeno',
      idade: '1 ano',
      img:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3g1PlXY0Ua0aWAq6yTdOyl2kRyf-VlGdvQw&usqp=CAU',
      raca: 'Viralata',
      descricao: 'Toma remedio controlado',
      contato: '996487115',
      data_registro: DateTime.now(),
    ),
  ];

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
        _animais_filter.addAll(_animais.where((e) => e.tipo == tipo));
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
                ? ListaAnimais(_animais)
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
