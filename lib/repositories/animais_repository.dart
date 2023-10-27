import 'dart:convert';
import 'dart:math';

import 'package:adocao_animais/models/animal.dart';
import 'package:adocao_animais/models/usuario.dart';
import '../data/my_data.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


class AnimaisRepository with ChangeNotifier {

  List<Animal> _animais = animaisData;

  List<Animal> get animais {
    return [..._animais];
  }

  Future<void> addAnimal(Animal animal) {
    final future = http.post(Uri.parse('$URLrepository/animais.json'),
        body: jsonEncode({
          "id": animal.id,
          // "dono": animal.dono,
          "novo": animal.novo,
          "tipo": animal.tipo,
          "nome": animal.nome,
          "porte": animal.porte,
          "sexo": animal.sexo,
          "idade": animal.idade,
          "img": animal.img,
          "raca": animal.raca,
          "descricao": animal.descricao,
          "data_registro": DateFormat('dd-MM-yyyy').format(animal.data_registro),
          "isFavorito": animal.isFavorito,
        }));
    return future.then((response) {
      _animais.add(Animal(
        id: animal.id,
        dono: animal.dono,
        novo: true,
        tipo: animal.tipo,
        nome: animal.nome,
        porte: animal.porte,
        sexo: animal.sexo,
        idade: animal.idade,
        img: animal.img,
        raca: animal.raca,
        descricao: animal.descricao,
        data_registro: animal.data_registro,
        isFavorito: animal.isFavorito
        ));
      notifyListeners();
    });
  }

  Future<void> saveAnimal(Map<String, Object> data, Usuario user) {
    bool hasId = data['id'] != null;
    bool hasDate = data['data_registro'] != null;

    final animal = Animal(
        id: hasId ? data['id'] as String : Random().nextDouble().toString(),
        dono: user,
        novo: false,
        tipo: data['tipo'].toString(),
        nome: data['nome'].toString(),
        porte: data['porte'].toString(),
        sexo: data['sexo'].toString(),
        idade: data['idade'].toString(),
        img: data['img'] as List<String>,
        raca: data['raca'].toString(),
        descricao: data['descricao'].toString(),
        data_registro: hasDate ? data['data_registro'] as DateTime : DateTime.now(),
        isFavorito: false,
    );
    if (hasId) {
      return updateAnimal(animal);
    } else {
      return addAnimal(animal);
    }
  }

  Future<void> updateAnimal(Animal animal) async {
    // int index = _items.indexWhere((p) => p.id == product.id);

    // var temp = _items.where((element) => element.id == product.id);
    // if (index >= 0) {
    //   _items[index] = product;
    //   notifyListeners();
    //   final future = await http.put(
    //       Uri.parse('$_baseUrl/products/${product.id}.json'),
    //       body: jsonEncode({
    //         "id": product.id,
    //         "title": product.title,
    //         "description": product.description,
    //         "price": product.price,
    //         "imageUrl": product.imageUrl,
    //         "isFavorite": temp.first.isFavorite,
    //       }),
    //       headers: {
    //         "Accept": "application/json"
    //       }).then((response) => print(response.statusCode));
    // }
    return Future.value();
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