import '../../domain/entity/pet.dart';
import '../../presentarion/state/pet_list_state.dart';
import '../../presentarion/state/pet_state.dart';

abstract interface class IPetApiService {
  Future<PetState> updatePet(Pet pet);
  Future<PetState> fetchByIdPet(int idPet);
  Future<PetListState> fetchByPet(String name);
  Future<PetListState> fetchAllPet();
}
