import 'dart:convert';
import 'dart:math';

import 'package:adocao_animais/data/my_data.dart';
import 'package:adocao_animais/models/adocao.dart';
import 'package:adocao_animais/models/animal.dart';
import 'package:adocao_animais/models/usuario.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


class AdocoesRepository with ChangeNotifier {

  List<Adocao> _dono_adocoes = [];
  List<Adocao> _user_adocoes = [];
  
  List<Adocao> get dono_adocoes {
    return [..._dono_adocoes];
  }

  List<Adocao> get user_adocoes {
    return [..._user_adocoes];
  }

  // adicionar uma adocao < a partir do usuario que deseja adotar >
  Future<bool> addAdocao(Animal animal, Usuario usuario){
    // transformando usuario de animal em map
    Map<String, dynamic> user_dono_map = {};
    user_dono_map["nome"] = animal.dono.nome;
    user_dono_map["email"] = animal.dono.email;
    user_dono_map["telefone"] = animal.dono.telefone;
    user_dono_map["cpf"] = animal.dono.cpf;
    user_dono_map["login"] = animal.dono.login;
    user_dono_map["senha"] = animal.dono.senha;

    // transformando usuario que deseja adotar em map
    Map<String, dynamic> user_map = {};
    user_map["nome"] = usuario.nome;
    user_map["email"] = usuario.email;
    user_map["telefone"] = usuario.telefone;
    user_map["cpf"] = usuario.cpf;
    user_map["login"] = usuario.login;
    user_map["senha"] = usuario.senha;

    // transformando animal em map
    Map<String, dynamic> animal_map = {};
    animal_map["dono"] = user_dono_map;
    animal_map["novo"] = false;
    animal_map["especie"] = animal.especie;
    animal_map["nome"] = animal.nome;
    animal_map["porte"] = animal.porte;
    animal_map["sexo"] = animal.sexo;
    animal_map["idade"] = animal.idade;
    animal_map["img"] = animal.img;
    animal_map["raca"] = animal.raca;
    animal_map["descricao"] = animal.descricao;
    animal_map["data_registro"] = animal.data_registro;
    animal_map["isFavorito"] = animal.isFavorito;

    var response = http.post(Uri.parse('${URLrepository}/adocoes.json'), 
      body: jsonEncode({
          "usuario": user_map,
          "animal": animal_map,
          "status": 'em processo...',
          "data": DateFormat('dd-MM-yyyy').format(DateTime.now()),
        })).then((value) {
          _user_adocoes.add(Adocao(usuario: usuario, animal: animal, status: 'status', data: DateTime.now()));
        });
      notifyListeners();

    return Future.value(true);
  }

  bool inUserAdocoes(Animal animal, String login){
    bool result = false;
    _user_adocoes.forEach((element) { 
      if(element.animal == animal && element.usuario.login == login){
        result = true;
      }
    });
    return result;
  }

  Future<bool> attAdocoes(Animal animal, Usuario usuario){
    if(usuario.login == ''){
      return Future.value(false);
    }
    
    // if(_dono_adocoes.where((element) => element.animal == animal).isEmpty){
    //   _dono_adocoes.add(Adocao(
    //           id: Random().toString(),
    //           animal: animal,
    //           status: 'em processo...',
    //           usuario: usuario,
    //           data: DateTime.now(),
    //   ));
    // } else {
    //   _dono_adocoes.removeWhere((element) => element.animal == animal);
    // }
    
    notifyListeners();
    return Future.value(true);
  }

}