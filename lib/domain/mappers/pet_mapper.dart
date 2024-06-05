import 'dart:convert';

import '../entity/pet.dart';

abstract class PetMapper {
  static Pet clone(Pet instance) => Pet(
        nome: instance.nome,
        raca: instance.raca,
        peso: instance.peso,
        dtNascimento: instance.dtNascimento,
      );

  static Map<String, dynamic> fromEntitytoMap(Pet instance) {
    return {
      'nome': instance.nome,
      'raca': instance.raca,
      'peso': instance.peso,
      'dtNascimento': instance.dtNascimento,
    };
  }

  static Pet fromMapToEntity(Map<String, dynamic> map) {
    return Pet(
      nome: map['nome'],
      raca: map['raca'],
      peso: map['peso'],
      dtNascimento: map['dtNascimento'],
    );
  }

  static Pet fromJsonToEntity(String source) =>
      fromMapToEntity(json.decode(source));

  static String fromEntityToJson(Pet instance) =>
      json.encode(fromEntitytoMap(instance));
}
