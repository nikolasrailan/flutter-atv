import 'package:asp_teste/domain/entity/pet.dart';
import 'package:faker_dart/faker_dart.dart';

abstract class PetFakeFactory {
  static Pet factory() {
    final faker = Faker.instance;
    faker.setLocale(FakerLocaleType.pt_PT);
    
    var instance = Pet(
      nome: faker.name.firstName(),
      raca: faker.animal.dog(),
    );
    return instance;
  }
}
