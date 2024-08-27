class User {
  final int id;
  final String usuario;
  final String email;
  final String senha;
  User({
    required this.id,
    required this.usuario,
    required this.email,
    required this.senha,
  });

  User copyWith({
    int? id,
    String? usuario,
    String? email,
    String? senha,
  }) {
    return User(
      id: id ?? this.id,
      usuario: usuario ?? this.usuario,
      email: email ?? this.email,
      senha: senha ?? this.senha,
    );
  }

  @override
  String toString() {
    return 'User(nome: $id, usuario: $usuario, email: $email, senha: $senha)';
  }
}
