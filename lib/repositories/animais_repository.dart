import 'dart:convert';

import 'package:adocao_animais/models/animal.dart';
import '../data/my_data.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;


class AnimaisRepository with ChangeNotifier {

  List<Animal> _animais = animaisData;

  List<Animal> get animais {
    return [..._animais];
  }


  // Future<List<Animal>> findByTipo(String tipo) async {
  //   List<Animal> result = [];
  //   final response = await http
  //       .get(Uri.parse(
  //         '${URLrepository}animals.json?orderBy="tipo"&equalTo="${tipo}"&print=pretty'))
  //       .then((value) {
  //         if(value.body.length > 10){
  //           late Animal? animal;
  //           Map<String, dynamic> map = json.decode(value.body);
  //           map.forEach((key, value) { 
  //             List<String> contatos = [];
  //             map[key]['contato'].map((e) {
  //               contatos.add(e);
  //             });
  //             animal = Animal(
  //               id: map[key]['id'],
  //               novo: map[key]['novo'],
  //               tipo: map[key]['tipo'],
  //               nome: map[key]['nome'],
  //               porte: map[key]['porte'], 
  //               sexo: map[key]['sexo'],
  //               idade: map[key]['idade'],
  //               img: map[key]['img'],
  //               raca: map[key]['raca'],
  //               descricao: map[key]['descricao'],
  //               data_registro: map[key]['data_registro'],
  //               contato: contatos,
  //               isFavorito: map[key]['favorito']
  //             );     

  //             result.add(animal!);
  //           });
            
  //         }
  //       });

  //   return Future.value(result);
  // }
}