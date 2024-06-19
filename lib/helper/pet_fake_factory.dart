import 'dart:math';

import 'package:asp_teste/domain/entity/pet.dart';
import 'package:faker_dart/faker_dart.dart';

abstract class PetFakeFactory {
  static Pet factory(int? id) {
    final faker = Faker.instance;
    faker.setLocale(FakerLocaleType.pt_PT);

    var instance = Pet(
      id: id ?? faker.datatype.number(min: 1),
      nome: faker.name.firstName(),
      raca: faker.animal.dog(),
      peso: faker.datatype.float(min: 0.1, max: 100.0),
      dtNascimento: faker.datatype.dateTime(
        min: DateTime.now().year - (Random().nextInt(10) + 1),
        max: DateTime.now().year,
      ),
    );
    return instance;
  }
}
