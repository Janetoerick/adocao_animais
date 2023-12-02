import 'package:adocao_animais/models/usuario.dart';

class Animal {
  final String id;
  final Usuario dono;
  final bool novo; // se é novo no abrigo (1 semana)
  final String especie; // Cachorro, Gato ...
  final String nome;
  final String porte; // Pequeno, Medio, Grande
  final String sexo; // Macho, Femea
  final String idade;
  final List<String> img;
  final String raca;
  final String descricao;
  final String data_registro;
  List<String> isFavorito;

  Animal({
    required this.id,
    required this.dono,
    required this.novo,
    required this.especie,
    required this.nome,
    required this.porte,
    required this.sexo,
    required this.idade,
    required this.img,
    required this.raca,
    required this.descricao,
    required this.data_registro,
    required this.isFavorito,
  });
}
