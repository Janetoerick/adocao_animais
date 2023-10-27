import 'dart:convert';
import 'dart:math';

import 'package:adocao_animais/models/animal.dart';
import 'package:adocao_animais/models/usuario.dart';
import '../data/my_data.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


class AnimaisRepository with ChangeNotifier {

  List<Animal> _animais = []; // animaisData

  AnimaisRepository(){
    _setUpProducts();
  }

  _setUpProducts() async {
    final response = await http.get(Uri.parse('$URLrepository/animais.json'));

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      json.forEach((key, element) {
        List<String> imagens = [];
        json[key]['img'].forEach((e) {
          imagens.add(e);
        });
        _animais.add(Animal(
            id: key,
            dono: json[key]['dono'],
            novo: json[key]['novo'],
            especie: json[key]['especie'],
            nome: json[key]['nome'],
            porte: json[key]['porte'],
            sexo: json[key]['sexo'],
            idade: json[key]['idade'],
            img: imagens,
            raca: json[key]['raca'],
            descricao: json[key]['descricao'],
            data_registro: json[key]['data_registro'],
            isFavorito: json[key]['isFavorito']));
      });
    }
    notifyListeners();
  }

  List<Animal> get animais {
    return [..._animais];
  }

  Future<void> addAnimal(Animal animal) {
    final future = http.post(Uri.parse('$URLrepository/animais.json'),
        body: jsonEncode({
          "id": animal.id,
          "dono": animal.dono,
          "novo": true,
          "especie": animal.especie,
          "nome": animal.nome,
          "porte": animal.porte,
          "sexo": animal.sexo,
          "idade": animal.idade,
          "img": animal.img,
          "raca": animal.raca,
          "descricao": animal.descricao,
          "data_registro": animal.data_registro,
          "isFavorito": animal.isFavorito,
        }));
    return future.then((response) {
      _animais.add(Animal(
        id: animal.id,
        dono: animal.dono,
        novo: true,
        especie: animal.especie,
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
        dono: user.login,
        novo: false,
        especie: data['especie'].toString(),
        nome: data['nome'].toString(),
        porte: data['porte'].toString(),
        sexo: data['sexo'].toString(),
        idade: data['idade'].toString(),
        img: data['img'] as List<String>,
        raca: data['raca'].toString(),
        descricao: data['descricao'].toString(),
        data_registro: hasDate ? data['data_registro'].toString() : DateFormat('dd-MM-yyyy').format(DateTime.now()),
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