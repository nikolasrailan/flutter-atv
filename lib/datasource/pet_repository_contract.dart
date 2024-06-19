import '../domain/entity/pet.dart';
import '../presentarion/state/pet_list_state.dart';
import '../presentarion/state/pet_state.dart';

abstract interface class IPetRepository {
  Future<PetState> updatePet(Pet pet);
  Future<PetState> getByIdPet(int idPet);
  Future<PetListState> getByPet(String name);
  Future<PetListState> getAllPet();
}
