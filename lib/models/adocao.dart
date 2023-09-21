import 'package:adocao_animais/models/animal.dart';

class Adocao {
  final String id;
  final String cpf_adotante;
  final String email_adotante;
  final Animal adotado;

  const Adocao({
    required this.id,
    required this.cpf_adotante,
    required this.email_adotante,
    required this.adotado,
  });
}
