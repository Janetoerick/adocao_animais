import 'dart:convert';
import 'dart:math';

import 'package:adocao_animais/data/my_data.dart';
import 'package:adocao_animais/models/adocao.dart';
import 'package:adocao_animais/models/animal.dart';
import 'package:adocao_animais/models/usuario.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

class UsuarioRepository with ChangeNotifier {
  Usuario _usuario =
      Usuario(nome: '', email: '', telefone: '', cpf: '', login: '', senha: '');
  List<Animal> _meus_animais = [];
  List<Animal> _animaisFav = [];

  Usuario get usuario {
    return _usuario;
  }

  List<Animal> get meus_animais {
    return [..._meus_animais];
  }

  List<Animal> get animaisFav {
    return [..._animaisFav];
  }

  Future<Usuario> loginUsuario(String login, String senha) async {
    Usuario user = new Usuario(
        nome: '', email: '', telefone: '', cpf: '', login: '', senha: '');
    final response = await http
        .get(Uri.parse(
            '${URLrepository}users.json?orderBy="login"&equalTo="${login}"&print=pretty'))
        .then((value) {
      if (value.body.length > 10) {
        Map<String, dynamic> map = json.decode(value.body);
        map.forEach((key, value) {
          user = Usuario(
              nome: map[key]['nome'],
              email: map[key]['email'],
              telefone: map[key]['telefone'],
              cpf: map[key]['cpf'],
              login: map[key]['login'],
              senha: map[key]['senha']);
        });
        if (user.senha == senha) {
          _usuario = user;
        }
      }
    });

    if (user.login != '') {
      setUpInitSection();
    }

    notifyListeners();

    return Future.value(user);
  }

  void setUpInitSection() async {
    _meus_animais = [];
    _animaisFav = [];
    var response = await http
        .get(Uri.parse('${URLrepository}/animais.json'))
        .then((value) {
      Map<String, dynamic> map = json.decode(value.body);
      map.forEach((key, value) {
        List<String> imgs = [];
        map[key]['img'].map((e) {
          imgs.add(e);
        }).toList();
        List<String> favorites = [];
        if (map[key]['isFavorito'] != null) {
          map[key]['isFavorito'].map((e) {
            favorites.add(e);
          }).toList();
        }
        Usuario temp_user = Usuario(
            nome: map[key]['dono']['nome'],
            email: map[key]['dono']['email'],
            telefone: map[key]['dono']['telefone'],
            cpf: map[key]['dono']['cpf'],
            login: map[key]['dono']['login'],
            senha: map[key]['dono']['senha']);

        if (map[key]['dono']['login'] == _usuario.login) {
          _meus_animais.add(Animal(
              id: key,
              dono: temp_user,
              novo: map[key]['novo'],
              especie: map[key]['especie'],
              nome: map[key]['nome'],
              porte: map[key]['porte'],
              sexo: map[key]['sexo'],
              idade: map[key]['idade'],
              img: imgs,
              raca: map[key]['raca'],
              descricao: map[key]['descricao'],
              data_registro: map[key]['data_registro'],
              isFavorito: favorites));
        }
        if (favorites.contains(_usuario.login)) {
          _animaisFav.add(Animal(
              id: key,
              dono: temp_user,
              novo: map[key]['novo'],
              especie: map[key]['especie'],
              nome: map[key]['nome'],
              porte: map[key]['porte'],
              sexo: map[key]['sexo'],
              idade: map[key]['idade'],
              img: imgs,
              raca: map[key]['raca'],
              descricao: map[key]['descricao'],
              data_registro: map[key]['data_registro'],
              isFavorito: favorites));
        }
      });
    });
  }

  void setUpMeusAnimais() async {
    var response = await http
        .get(Uri.parse('${URLrepository}/animais.json'))
        .then((value) {
      Map<String, dynamic> map = json.decode(value.body);
      _meus_animais = [];
      map.forEach((key, value) {
        if (map[key]['dono']['login'] == _usuario.login) {
          List<String> imgs = [];
          map[key]['img'].map((e) {
            imgs.add(e);
          }).toList();

          List<String> favorites = [];
          if (map[key]['isFavorito'] != null) {
            map[key]['isFavorito'].map((e) {
              favorites.add(e);
            }).toList();
          }

          _meus_animais.add(Animal(
              id: key,
              dono: _usuario,
              novo: map[key]['novo'],
              especie: map[key]['especie'],
              nome: map[key]['nome'],
              porte: map[key]['porte'],
              sexo: map[key]['sexo'],
              idade: map[key]['idade'],
              img: imgs,
              raca: map[key]['raca'],
              descricao: map[key]['descricao'],
              data_registro: map[key]['data_registro'],
              isFavorito: favorites));
        }
      });
    });
    notifyListeners();
  }

  void addMeusAnimais(Animal animal) {
    if (_meus_animais.where((element) => element.id == animal.id).isEmpty) {
      _meus_animais.add(animal);
    } else {
      _meus_animais.removeWhere((element) => element.id == animal.id);
      _meus_animais.add(animal);
    }

    notifyListeners();
  }

  void removeMeusAnimais(Animal animal) {
    _meus_animais.remove(animal);
    notifyListeners();
  }

  Animal findMeuAnimalByAnimal(Animal animal) {
    List<Animal> result =
        _meus_animais.where((element) => element.id == animal.id).toList();
    return result[0];
  }

  Future<void> logoutUsuario() {
    _usuario = Usuario(
        nome: '', email: '', telefone: '', cpf: '', login: '', senha: '');
    _animaisFav.clear();

    notifyListeners();

    return Future.value();
  }

  Future<bool> cadastrarUsuario(Usuario usuario) async {
    bool _userExists = false;
    final response = await http
        .get(Uri.parse(
            '${URLrepository}users.json?orderBy="login"&equalTo="${usuario.login}"&print=pretty'))
        .then((value) {
      if (value.body.length > 10) {
        _userExists = true;
      }
    });
    if (!_userExists) {
      http
          .post(Uri.parse('$URLrepository/users.json'),
              body: jsonEncode({
                "nome": usuario.nome,
                "email": usuario.email,
                "telefone": usuario.telefone,
                "cpf": usuario.cpf,
                "login": usuario.login,
                "senha": usuario.senha,
              }))
          .then((value) {});
      return Future.value(true);
    }
    return Future.value(false);
  }

  Future<bool> attAnimalFav(Animal animal) {
    if (_usuario.login == '') {
      return Future.value(false);
    }

    bool itsRemove = false;
    _animaisFav.forEach((element) {
      if (element.id == animal.id) {
        itsRemove = true;
      }
    });

    if (itsRemove) {
      _animaisFav.removeWhere((element) => element.id == animal.id);
    } else {
      _animaisFav.add(animal);
    }

    notifyListeners();
    return Future.value(true);
  }

  bool isFavorito(Animal animal) {
    bool result = false;
    _animaisFav.forEach((element) {
      if (element.id == animal.id) {
        result = true;
      }
    });
    return result;
  }
}
