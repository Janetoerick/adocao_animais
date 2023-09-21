import 'package:adocao_animais/models/animal.dart';

class Abrigo {
  final String id;
  final String nome;
  final List<Animal> animais;

  const Abrigo({
    required this.id,
    required this.nome,
    required this.animais,
  });
}
