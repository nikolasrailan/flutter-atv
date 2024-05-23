class Pet {
  final String nome;
  final String raca;
  Pet({
    required this.nome,
    required this.raca,
  });

  Pet copyWith({
    String? nome,
    String? raca,
  }) {
    return Pet(
      nome: nome ?? this.nome,
      raca: raca ?? this.raca,
    );
  }

  @override
  String toString() => 'Pet(nome: $nome, raca: $raca)';
}
