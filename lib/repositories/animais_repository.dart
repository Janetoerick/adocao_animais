import 'package:adocao_animais/models/animal.dart';
import '../data/my_data.dart';
import 'package:flutter/cupertino.dart';


class AnimaisRepository with ChangeNotifier {

  List<Animal> _animais = animaisData;
  bool _showFavorite = false;

  List<Animal> get animais {
    return [..._animais];
  }
}