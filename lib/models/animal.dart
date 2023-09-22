class Animal {
  final String id;
  final bool novo; // se é novo no abrigo (1 semana)
  final String tipo; // Cachorro, Gato ...
  final String nome;
  final String porte; // Pequeno, Medio, Grande
  final String sexo; // Macho, Femea
  final String idade;
  final String img;
  final String raca;
  final String descricao;

  const Animal({
    required this.id,
    required this.novo,
    required this.tipo,
    required this.nome,
    required this.porte,
    required this.sexo,
    required this.idade,
    required this.img,
    required this.raca,
    required this.descricao,
  });
}
