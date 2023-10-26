import 'dart:math';

import 'package:adocao_animais/models/adocao.dart';
import 'package:adocao_animais/models/animal.dart';
import 'package:adocao_animais/models/usuario.dart';
import 'package:flutter/cupertino.dart';


class UsuarioRepository with ChangeNotifier {

  Usuario _usuario = Usuario(id: '', nome: '', email: '', telefone: '', cpf: '', login: '', senha: '');
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

  Future<bool> attAnimalFav(Animal animal){
    if(_usuario.id == ''){
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
    if(_usuario.id == ''){
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

  bool isAdotado(Animal animal){
    if(_adocoes.where((element) => element.animal == animal).isEmpty){
      return false;
    }
    return true;
  }
}