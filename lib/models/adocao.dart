import 'package:adocao_animais/models/animal.dart';
import 'package:adocao_animais/models/usuario.dart';

class Adocao {
  final String id;
  final Usuario usuario;
  final Animal animal;
  final String status;
  final String data;

  const Adocao({
    required this.id,
    required this.usuario,
    required this.animal,
    required this.status,
    required this.data,
  });
}
