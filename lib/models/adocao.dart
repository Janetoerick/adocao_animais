import 'package:adocao_animais/models/animal.dart';
import 'package:adocao_animais/models/usuario.dart';

class Adocao {
  final Usuario usuario;
  final Animal animal;
  final String status;
  final DateTime data;

  const Adocao({
    required this.usuario,
    required this.animal,
    required this.status,
    required this.data,
  });
}
