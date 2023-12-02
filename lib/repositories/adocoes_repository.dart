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

  void setUpAdocoesAccount(Usuario usuario) async {
    final response = await http.get(Uri.parse('${URLrepository}/adocoes.json'));
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      json.forEach((key, value) {
        final isUser = json[key]['usuario']['login'] == usuario.login;
        final isDono = json[key]['animal']['dono']['login'] == usuario.login;
        if (isUser || isDono) {
          // verifica se o usuario esta envolvido com a doacao
          // transforma imagens em list
          List<String> imagens = [];
          json[key]['animal']['img'].forEach((e) {
            imagens.add(e);
          });
          //transforma favoritos em list
          List<String> favorites = [];
          if (json[key]['animal']['isFavorito'] != null) {
            json[key]['animal']['isFavorito'].map((e) {
              favorites.add(e);
            }).toList();
          }

          if (isUser) {
            // caso seja o usuario da adocao
            Usuario dono = Usuario(
                nome: json[key]['animal']['dono']['nome'],
                email: json[key]['animal']['dono']['email'],
                telefone: json[key]['animal']['dono']['telefone'],
                cpf: json[key]['animal']['dono']['cpf'],
                login: json[key]['animal']['dono']['login'],
                senha: json[key]['animal']['dono']['senha']);

            Animal animal = Animal(
                id: json[key]['animal']['id'],
                dono: dono,
                novo: json[key]['animal']['novo'],
                especie: json[key]['animal']['especie'],
                nome: json[key]['animal']['nome'],
                porte: json[key]['animal']['porte'],
                sexo: json[key]['animal']['sexo'],
                idade: json[key]['animal']['idade'],
                img: imagens,
                raca: json[key]['animal']['raca'],
                descricao: json[key]['animal']['descricao'],
                data_registro: json[key]['animal']['data_registro'],
                isFavorito: favorites);
            _user_adocoes.add(Adocao(
                id: key,
                usuario: usuario,
                animal: animal,
                status: json[key]['status'],
                data: json[key]['data']));
          } else if (isDono) {
            // caso seja o dono da doacao
            Usuario user = Usuario(
                nome: json[key]['usuario']['nome'],
                email: json[key]['usuario']['email'],
                telefone: json[key]['usuario']['telefone'],
                cpf: json[key]['usuario']['cpf'],
                login: json[key]['usuario']['login'],
                senha: json[key]['usuario']['senha']);

            Animal animal = Animal(
                id: json[key]['animal']['id'],
                dono: usuario,
                novo: json[key]['animal']['novo'],
                especie: json[key]['animal']['especie'],
                nome: json[key]['animal']['nome'],
                porte: json[key]['animal']['porte'],
                sexo: json[key]['animal']['sexo'],
                idade: json[key]['animal']['idade'],
                img: imagens,
                raca: json[key]['animal']['raca'],
                descricao: json[key]['animal']['descricao'],
                data_registro: json[key]['animal']['data_registro'],
                isFavorito: favorites);
            _dono_adocoes.add(Adocao(
                id: key,
                usuario: user,
                animal: animal,
                status: json[key]['status'],
                data: json[key]['data']));
          }
        }
      });
      notifyListeners();
    }
  }

  // adicionar uma adocao < a partir do usuario que deseja adotar >
  Future<bool> addAdocao(Animal animal, Usuario usuario) async {
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
    animal_map["id"] = animal.id;
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

    var response = await http
        .post(Uri.parse('${URLrepository}/adocoes.json'),
            body: jsonEncode({
              "usuario": user_map,
              "animal": animal_map,
              "status": 'em processo...',
              "data": DateFormat('dd-MM-yyyy').format(DateTime.now()),
            }))
        .then((value) {
      final id = jsonDecode(value.body)['name'];
      _user_adocoes.add(Adocao(
          id: id,
          usuario: usuario,
          animal: animal,
          status: 'em processo...',
          data: DateFormat('dd-MM-yyyy').format(DateTime.now())));
    });
    notifyListeners();

    return Future.value(true);
  }

  // Para atualizar uma adoção específica
  Future<bool> attAdocoes(Adocao adocao, bool isDono) async {
    // transformando usuario de animal em map
    Map<String, dynamic> user_dono_map = {};
    user_dono_map["nome"] = adocao.animal.dono.nome;
    user_dono_map["email"] = adocao.animal.dono.email;
    user_dono_map["telefone"] = adocao.animal.dono.telefone;
    user_dono_map["cpf"] = adocao.animal.dono.cpf;
    user_dono_map["login"] = adocao.animal.dono.login;
    user_dono_map["senha"] = adocao.animal.dono.senha;

    // transformando usuario que deseja adotar em map
    Map<String, dynamic> user_map = {};
    user_map["nome"] = adocao.usuario.nome;
    user_map["email"] = adocao.usuario.email;
    user_map["telefone"] = adocao.usuario.telefone;
    user_map["cpf"] = adocao.usuario.cpf;
    user_map["login"] = adocao.usuario.login;
    user_map["senha"] = adocao.usuario.senha;

    // transformando animal em map
    Map<String, dynamic> animal_map = {};
    animal_map["id"] = adocao.animal.id;
    animal_map["dono"] = user_dono_map;
    animal_map["novo"] = adocao.animal.novo;
    animal_map["especie"] = adocao.animal.especie;
    animal_map["nome"] = adocao.animal.nome;
    animal_map["porte"] = adocao.animal.porte;
    animal_map["sexo"] = adocao.animal.sexo;
    animal_map["idade"] = adocao.animal.idade;
    animal_map["img"] = adocao.animal.img;
    animal_map["raca"] = adocao.animal.raca;
    animal_map["descricao"] = adocao.animal.descricao;
    animal_map["data_registro"] = adocao.animal.data_registro;
    animal_map["isFavorito"] = adocao.animal.isFavorito;

    var response =
        await http.put(Uri.parse('${URLrepository}/adocoes/${adocao.id}.json'),
            body: jsonEncode({
              "usuario": user_map,
              "animal": animal_map,
              "status": adocao.status,
              "data": adocao.data,
            }),
            headers: {"Accept": "application/json"}).then((value) {
      if (isDono) {
        _dono_adocoes.removeWhere((element) => element.id == adocao.id);
        _dono_adocoes.add(adocao);
      } else {
        _user_adocoes.removeWhere((element) => element.id == adocao.id);
        _user_adocoes.add(adocao);
      }
    });
    notifyListeners();
    return Future.value(true);
  }

  // Para atualizar um conjunto de adoções que tenham o animal
  Future<void> attAdocoesByAnimal(
      Map<String, dynamic> animal, Usuario user) async {
    int length = _dono_adocoes
        .where((element) => element.animal.id == animal['id'])
        .length;

    if (length > 0) {
      // Caso o animal esteja em alguma adocao

      // transformando usuario de animal em map
      Map<String, dynamic> user_map = {};
      user_map["nome"] = user.nome;
      user_map["email"] = user.email;
      user_map["telefone"] = user.telefone;
      user_map["cpf"] = user.cpf;
      user_map["login"] = user.login;
      user_map["senha"] = user.senha;
      animal['dono'] = user_map;

      // // transformando animal em map
      // Map<String, dynamic> animal_map = {};
      // animal_map["id"] = animal.id;
      // animal_map["dono"] = user_dono_map;
      // animal_map["novo"] = animal.novo;
      // animal_map["especie"] = animal.especie;
      // animal_map["nome"] = animal.nome;
      // animal_map["porte"] = animal.porte;
      // animal_map["sexo"] = animal.sexo;
      // animal_map["idade"] = animal.idade;
      // animal_map["img"] = animal.img;
      // animal_map["raca"] = animal.raca;
      // animal_map["descricao"] = animal.descricao;
      // animal_map["data_registro"] = animal.data_registro;
      // animal_map["isFavorito"] = animal.isFavorito;

      final response = await http
          .get(Uri.parse('${URLrepository}/adocoes.json'))
          .then((value) {
        Map<String, dynamic> map = jsonDecode(value.body);
        map.forEach((key, value) {
          if (map[key]['animal']['id'] == animal['id']) {
            http.put(Uri.parse('${URLrepository}/adocoes/${key}.json'),
                body: jsonEncode({
                  "usuario": map[key]["usuario"],
                  "animal": animal,
                  "status": map[key]["status"],
                  "data": map[key]["data"],
                }),
                headers: {"Accept": "application/json"});
          }
        });
      });
    }

    return Future.value();
  }

  // Deletar uma adoção <como só quem pode deletar é o usuário que solicitou, só faz mudança no _user_adocoes>
  Future<void> deleteAdocao(Adocao adocao) async {
    final response = await http.delete(
      Uri.parse('${URLrepository}/adocoes/${adocao.id}.json'),
      headers: {
        'Content-Type': 'application/json',
      },
    ).then((value) {
      _user_adocoes.remove(adocao);
    });
    notifyListeners();
    return Future.value();
  }

  Future<void> deleteAdocaoByAnimal(Animal animal) async {
    List<String> id_adocoes_remove = [];
    final response = await http
        .get(Uri.parse('${URLrepository}/adocoes.json'))
        .then((value) {
      Map<String, dynamic> map = jsonDecode(value.body);

      map.forEach((key, value) {
        if (map[key]['animal']['id'] == animal.id) {
          id_adocoes_remove.add(key);
        }
      });
    });

    _dono_adocoes.removeWhere((element) => element.animal.id == animal.id);

    notifyListeners();
    id_adocoes_remove.forEach((element) {
      final deletes = http.delete(
        Uri.parse('${URLrepository}/adocoes/${element}.json'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
    });
    return Future.value();
  }

  bool inUserAdocoes(Animal animal, String login) {
    bool result = false;
    _user_adocoes.forEach((element) {
      if (element.animal.id == animal.id && element.usuario.login == login) {
        result = true;
      }
    });
    return result;
  }

  void ClearAll() {
    _dono_adocoes.clear();
    _user_adocoes.clear();

    notifyListeners();
  }

  List<Adocao> findByAnimal(Animal animal) {
    List<Adocao> result = [];
    Adocao? adocao;
    _user_adocoes.forEach((element) {
      if (element.animal.id == animal.id) {
        result.add(element);
      }
    });
    if (adocao == null) {
      _dono_adocoes.forEach((element) {
        if (element.animal.id == animal.id) {
          result.add(element);
        }
      });
    }

    return result;
  }

  List<Adocao> findByStatus(String status, bool isDono) {
    List<Adocao> result = [];
    if (isDono) {
      _dono_adocoes.forEach((element) {
        if (element.status == status) {
          result.add(element);
        }
      });
    } else {
      _user_adocoes.forEach((element) {
        if (element.status == status) {
          result.add(element);
        }
      });
    }
    return result;
  }
}
