import '../../presentarion/state/pet_list_state.dart';

abstract interface class IPetApiService {
  Future<PetListState> fetchByPet(String name);
  Future<PetListState> fetchAllPet();
}
