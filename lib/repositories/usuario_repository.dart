import 'dart:convert';
import 'dart:math';

import 'package:adocao_animais/data/my_data.dart';
import 'package:adocao_animais/models/adocao.dart';
import 'package:adocao_animais/models/animal.dart';
import 'package:adocao_animais/models/usuario.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;


class UsuarioRepository with ChangeNotifier {

  Usuario _usuario = Usuario(nome: '', email: '', telefone: '', cpf: '', login: '', senha: '');
  List<Animal> _animaisFav = [];
  List<Adocao> _adocoes = [];

  Usuario get usuario {
    return _usuario;
  }

  List<Animal> get animaisFav {
    return [..._animaisFav];
  }

  List<Adocao> get adocoes {
    return [..._adocoes];
  }

  Future<String> loginUsuario(String login, String senha) async{
    String result = 'OK';
    final response = await http
        .get(Uri.parse(
          '${URLrepository}users.json?orderBy="login"&equalTo="${login}"&print=pretty'))
        .then((value) {
          if(value.body.length > 10){
            Usuario user = new Usuario(nome: '', email: '', telefone: '', cpf: '', login: '', senha: '');
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
            if(user.senha == senha){
              _usuario = user;
            } else {
              result = 'Senha incorreta';
            }
          } else {
            result = 'Login não existe';
          }
        });
        notifyListeners();

    return Future.value(result);
  }

  Future<void> logoutUsuario(){
    _usuario = Usuario(nome: '', email: '', telefone: '', cpf: '', login: '', senha: '');
    _animaisFav.clear();
    _adocoes.clear();

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
          .then((value) => print(value.statusCode));
      return Future.value(true);
    }
    return Future.value(false);
  }

  Future<bool> attAnimalFav(Animal animal){
    if(_usuario.login == ''){
      return Future.value(false);
    }
    
    if(_animaisFav.contains(animal)){
      _animaisFav.remove(animal);
    } else {
      _animaisFav.add(animal);
    }
    
    notifyListeners();
    return Future.value(true);
  }

  Future<bool> attAdocoes(Animal animal){
    if(_usuario.login == ''){
      return Future.value(false);
    }
    
    if(_adocoes.where((element) => element.animal == animal).isEmpty){
      _adocoes.add(Adocao(
              id: Random().toString(),
              animal: animal,
              status: 'em processo...',
              usuario: _usuario,
              data: DateTime.now(),
      ));
    } else {
      _adocoes.removeWhere((element) => element.animal == animal);
    }
    
    notifyListeners();
    return Future.value(true);
  }

  Future<Usuario> findByLogin(String login) async {
    Usuario result = Usuario(nome: '', email: '', telefone: '', cpf: '', login: '', senha: '');
    final response = await http
        .get(Uri.parse(
            '${URLrepository}users.json?orderBy="login"&equalTo="${login}"&print=pretty'))
        .then((value) {
      if (value.body.length > 10) {
        Map<String, dynamic> map = json.decode(value.body);
        map.forEach((key, value) { 
          result = Usuario(
            nome: map[key]['nome'], 
            email: map[key]['email'], 
            telefone: map[key]['telefone'], 
            cpf: map[key]['cpf'], 
            login: login, 
            senha: map[key]['senha']);
        });
      }
    });
    return Future.value(result);
  }

  bool isAdotado(Animal animal){
    if(_adocoes.where((element) => element.animal == animal).isEmpty){
      return false;
    }
    return true;
  }


}