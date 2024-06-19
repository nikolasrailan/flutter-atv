import 'dart:convert';

import '../entity/pet.dart';

abstract class PetMapper {
  static Pet clone(Pet instance) => Pet(
        id: instance.id,
        nome: instance.nome,
        raca: instance.raca,
        peso: instance.peso,
        dtNascimento: instance.dtNascimento,
      );

  static Map<String, dynamic> fromEntitytoMap(Pet instance) {
    return {
      'id': instance.id,
      'nome': instance.nome,
      'raca': instance.raca,
      'peso': instance.peso,
      'dtNascimento': instance.dtNascimento.toIso8601String(),
    };
  }

  static Pet fromMapToEntity(Map<String, dynamic> map) {
    return Pet(
      id: map['id'],
      nome: map['nome'],
      raca: map['raca'],
      peso: map['peso'],
      dtNascimento: DateTime.parse(map['dtNascimento']),
    );
  }

  static Pet fromJsonToEntity(String source) =>
      fromMapToEntity(json.decode(source));

  static String fromEntityToJson(Pet instance) =>
      json.encode(fromEntitytoMap(instance));
}
