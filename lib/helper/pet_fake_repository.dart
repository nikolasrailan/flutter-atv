import 'dart:math';

import '../domain/entity/pet.dart';
import '../domain/mappers/pet_mapper.dart';
import '../core/errors/errors_classes.dart';
import 'pet_fake_factory.dart';

class PetsFakApiDataBase {
  late List<Pet> pets;

  PetsFakApiDataBase({int numInstance = 10}) {
    pets = List.generate(numInstance, (_) => PetFakeFactory.factory());
  }

  Future<List<Pet>> getAllPet() async {
    final filter = null;
    
    if (Random().nextBool()) {
      return throw APIFailure('meu erro');
    }

    final pets = _filter(filter: filter);

    return pets == null || pets.isEmpty
        ? throw DatasourceResultEmpty()
        : pets.map((e) => PetMapper.clone(e)).toList();
  }

  Future<Pet> getPet() async {
    return pets.isEmpty
        ? throw DatasourceResultEmpty()
        : PetMapper.clone(
            pets[Random().nextInt(pets.length)],
          );
  }

  Future<List<Pet>> getByName(String name) async {
    final filter = name != null && name.trim().isNotEmpty
        ? (Pet d) => d.nome.toLowerCase().contains(name.toLowerCase().trim())
        : throw InvalidSearchText();

    final instances = _filter(filter: filter);

    return instances == null || instances.isEmpty
        ? throw DatasourceResultEmpty()
        : instances.map((e) => PetMapper.clone(e)).toList();
  }

  List<Pet> _filter({bool Function(Pet)? filter}) {
    final pets = filter == null ? this.pets : this.pets.where(filter).toList();

    return pets;
  }
}
