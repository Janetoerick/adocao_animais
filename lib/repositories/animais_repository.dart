import 'dart:convert';
import 'dart:math';

import 'package:adocao_animais/models/animal.dart';
import 'package:adocao_animais/models/usuario.dart';
import 'package:adocao_animais/repositories/usuario_repository.dart';
import '../data/my_data.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AnimaisRepository with ChangeNotifier {
  List<Animal> _animais = []; // animaisData

  AnimaisRepository() {
    setUpAnimais();
  }

  setUpAnimais() async {
    final response = await http.get(Uri.parse('$URLrepository/animais.json'));
    if (response.statusCode == 200) {
      _animais.clear();
      Map<String, dynamic> json = jsonDecode(response.body);
      json.forEach((key, element) {
        _animais.add(convertJsonToAnimal(json[key], key));
      });
    }
    notifyListeners();
  }

  void setUpAnimaisLogin(String login) async {
    _animais.clear();
    final response = await http.get(Uri.parse('$URLrepository/animais.json'));

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      json.forEach((key, element) {
        if (json[key]['dono']['login'] != login) {
          _animais.add(convertJsonToAnimal(json[key], key));
        }
      });
    }
    notifyListeners();
  }

  Animal convertJsonToAnimal(Map<String, dynamic> json, String key) {
    List<String> imagens = [];
    json['img'].forEach((e) {
      imagens.add(e);
    });

    Usuario user_temp = Usuario(
        nome: json['dono']['nome'],
        email: json['dono']['email'],
        telefone: json['dono']['telefone'],
        cpf: json['dono']['cpf'],
        login: json['dono']['login'],
        senha: json['dono']['senha']);
    List<String> favorites = [];
    if (json['isFavorito'] != null) {
      json['isFavorito'].map((e) {
        favorites.add(e);
      }).toList();
    }
    return Animal(
        id: key,
        dono: user_temp,
        novo: json['novo'],
        especie: json['especie'],
        nome: json['nome'],
        porte: json['porte'],
        sexo: json['sexo'],
        idade: json['idade'],
        img: imagens,
        raca: json['raca'],
        descricao: json['descricao'],
        data_registro: json['data_registro'],
        isFavorito: favorites);
  }

  List<Animal> get animais {
    return [..._animais];
  }

  Future<void> addAnimal(Animal animal) {
    Map<String, dynamic> user_map = {};
    user_map["nome"] = animal.dono.nome;
    user_map["email"] = animal.dono.email;
    user_map["telefone"] = animal.dono.telefone;
    user_map["cpf"] = animal.dono.cpf;
    user_map["login"] = animal.dono.login;
    user_map["senha"] = animal.dono.senha;

    final future = http.post(Uri.parse('$URLrepository/animais.json'),
        body: jsonEncode({
          "dono": user_map,
          "novo": false,
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
      // final id = jsonDecode(response.body)['name'];
      // _animais.add(Animal(
      //   id: id,
      //   dono: animal.dono,
      //   novo: false,
      //   especie: animal.especie,
      //   nome: animal.nome,
      //   porte: animal.porte,
      //   sexo: animal.sexo,
      //   idade: animal.idade,
      //   img: animal.img,
      //   raca: animal.raca,
      //   descricao: animal.descricao,
      //   data_registro: animal.data_registro,
      //   isFavorito: animal.isFavorito
      // ));
      // notifyListeners();
    });
  }

  Future<void> saveAnimal(Map<String, Object> data, Usuario user) {
    bool hasId = data['id'] != null;
    bool hasDate = data['data_registro'] != null;

    List<String> favorites = [];
    favorites.addAll(
        data['favorito'] != null ? data['favorito'] as List<String> : []);

    final animal = Animal(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      dono: user,
      novo: false,
      especie: data['especie'].toString(),
      nome: data['nome'].toString(),
      porte: data['porte'].toString(),
      sexo: data['sexo'].toString(),
      idade: data['idade'].toString(),
      img: data['img'] as List<String>,
      raca: data['raca'].toString(),
      descricao: data['descricao'].toString(),
      data_registro: hasDate
          ? data['data_registro'].toString()
          : DateFormat('dd-MM-yyyy').format(DateTime.now()),
      isFavorito: favorites,
    );
    if (hasId) {
      return updateAnimal(animal);
    } else {
      return addAnimal(animal);
    }
  }

  Future<void> updateAnimal(Animal animal) async {
    Map<String, dynamic> user_map = {};
    user_map["nome"] = animal.dono.nome;
    user_map["email"] = animal.dono.email;
    user_map["telefone"] = animal.dono.telefone;
    user_map["cpf"] = animal.dono.cpf;
    user_map["login"] = animal.dono.login;
    user_map["senha"] = animal.dono.senha;
    final future =
        await http.put(Uri.parse('${URLrepository}/animais/${animal.id}.json'),
            body: jsonEncode({
              "dono": user_map,
              "novo": animal.novo,
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
            }),
            headers: {"Accept": "application/json"}).then((response) {});
    return Future.value();
  }

  Future<void> removeAnimal(Animal animal) async {
    final future = await http.delete(
      Uri.parse('${URLrepository}/animais/${animal.id}.json'),
      headers: {
        'Content-Type': 'application/json',
      },
    ).then((response) {});

    return Future.value();
  }

  Animal findByid(String id) {
    List<Animal> result = [];
    result = _animais.where((element) => element.id == id).toList();

    return result[0];
  }

  bool isDonoAnimal(Animal animal) {
    List<Animal> list_temp = [];
    list_temp = _animais.where((element) => element.id == animal.id).toList();
    if (list_temp.length > 0) {
      return false;
    }
    return true;
  }

  Future<void> attFavorito(Animal animal, Usuario user) {
    _animais.forEach((e) {
      if (e.id == animal.id) {
        if (animal.isFavorito
            .where((element) => element == user.login)
            .isEmpty) {
          animal.isFavorito.add(user.login);
        } else {
          animal.isFavorito.remove(user.login);
        }
        e.isFavorito = animal.isFavorito;
      }
    });
    notifyListeners();

    updateAnimal(animal);

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
