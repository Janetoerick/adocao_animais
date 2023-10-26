class Usuario {
  final String nome;
  final String email;
  final String telefone;
  final String cpf;
  final String login; // CHAVE <-
  final String senha;

  const Usuario({
    required this.nome,
    required this.email,
    required this.telefone,
    required this.cpf,
    required this.login,
    required this.senha,
  });
}

class UsuarioInvalido extends Usuario {
  UsuarioInvalido()
      : super(
          nome: '',
          email: '',
          telefone: '',
          cpf: '',
          login: '',
          senha: '',
        );
}

// Classe de Gerenciamento de Usuários
class GerenciadorUsuarios {
  List<Usuario> _usuarios = [
    Usuario(
      nome: 'João',
      email: 'joao@example.com',
      telefone: '123456789',
      cpf: '123.456.789-01',
      login: 'joao123',
      senha: 'senha123',
    ),
    Usuario(
      nome: 'Maria',
      email: 'maria@example.com',
      telefone: '987654321',
      cpf: '987.654.321-02',
      login: 'maria456',
      senha: 'senha456',
    ),
  ];

  // Método para verificar credenciais de login
  Usuario fazerLogin(String login, String senha) {
    final usuario = _usuarios.firstWhere(
      (u) => u.login == login && u.senha == senha,
      orElse: () => UsuarioInvalido(),
    );

    return usuario;
  }

  // Método para verificar se um nome de usuário já está em uso
  bool loginEmUso(String login) {
    return _usuarios.any((u) => u.login == login);
  }

  // Método para adicionar um novo usuário
  void cadastrarNovoUsuario({
    required String nome,
    required String email,
    required String telefone,
    required String cpf,
    required String login,
    required String senha,
  }) {
    final novoUsuario = Usuario(
      nome: nome,
      email: email,
      telefone: telefone,
      cpf: cpf,
      login: login,
      senha: senha,
    );
    _usuarios.add(novoUsuario);
  }
}
