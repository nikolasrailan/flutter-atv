class Pet {
  final int id;
  final String nome;
  final String raca;
  final double peso;
  final DateTime dtNascimento;
  Pet({
    required this.id,
    required this.nome,
    required this.raca,
    required this.peso,
    dtNascimento,
  }) : dtNascimento = dtNascimento != null
            ? DateTime(dtNascimento.year, dtNascimento.month, dtNascimento.day)
            : DateTime(
                DateTime.now().year,
                DateTime.now().minute,
                DateTime.now().day,
              );

  int get idade {
    final hoje = DateTime.now();
    int idade = hoje.year - dtNascimento.year;
    if (hoje.month < dtNascimento.month ||
        (hoje.month == dtNascimento.month && hoje.day < dtNascimento.day)) {
      idade--;
    }
    return idade;
  }

  Pet copyWith({
    int? id,
    String? nome,
    String? raca,
    double? peso,
    DateTime? dtNascimento,
  }) {
    return Pet(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      raca: raca ?? this.raca,
      peso: peso ?? this.peso,
      dtNascimento: dtNascimento ?? this.dtNascimento,
    );
  }

  @override
  String toString() {
    return 'Pet(nome: $id, nome: $nome, raca: $raca, peso: $peso, dtNascimento: $dtNascimento, idade: $idade)';
  }
}
