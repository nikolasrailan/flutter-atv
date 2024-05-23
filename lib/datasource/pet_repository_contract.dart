import '../presentarion/state/pet_list_state.dart';

abstract interface class IPetRepository {
  Future<PetListState> getByPet(String name);
  Future<PetListState> getAllPet();
}
