import 'dart:math';

import '../core/errors/errors_classes.dart';
import '../core/errors/errors_messagens.dart';
import '../domain/entity/pet.dart';
import '../domain/mappers/pet_mapper.dart';
import 'pet_fake_factory.dart';

class PetsFakApiDataBase {
  late List<Pet> pets;

  PetsFakApiDataBase({int numInstance = 10}) {
    pets = List.generate(
      numInstance,
      (int index) => PetFakeFactory.factory(index + 1),
    );
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

  Future<void> updatePet(Pet pet) async {
    try {
      int index = pets.indexWhere((petItem) => petItem.id == pet.id);

      if (index != -1) {
        pets[index] = pet.copyWith();
      }
      throw PetNotFound(MessagesError.petNotFoundError);
    } catch (e) {
      throw DefaultError(e.toString());
    }
  }

  Future<Pet> getPetRanbom() async {
    return pets.isEmpty
        ? throw DatasourceResultEmpty()
        : PetMapper.clone(
            pets[Random().nextInt(pets.length)],
          );
  }

  Future<List<Pet>> getByName(String name) async {
    final filter = name.trim().isNotEmpty
        ? (Pet d) => d.nome.toLowerCase().contains(name.toLowerCase().trim())
        : throw InvalidSearchText();

    final instances = _filter(filter: filter);

    return instances.isEmpty
        ? throw DatasourceResultEmpty()
        : instances.map((e) => PetMapper.clone(e)).toList();
  }

  Future<Pet> getPetById(int idPet) async {
    final filter = (idPet > 0)
        ? (Pet d) => d.id == idPet
        : throw InvalidSearchText(MessagesError.idError);
    final instances = _filterPet(filter: filter);

    if (instances == null) {
      throw DatasourceResultEmpty(MessagesError.petNotFoundError);
    }

    return instances;
  }

  List<Pet> _filter({bool Function(Pet)? filter}) {
    final pets = filter == null ? this.pets : this.pets.where(filter).toList();

    return pets;
  }

  Pet? _filterPet({required bool Function(Pet) filter}) {
    try {
      return pets.firstWhere(filter);
    } catch (e) {
      return null;
    }
  }
}
