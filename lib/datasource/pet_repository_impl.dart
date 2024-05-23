import '../external/services/pet_api_contract.dart';
import '../presentarion/state/pet_list_state.dart';
import 'pet_repository_contract.dart';

class PetRepositoryImpl implements IPetRepository {
  IPetApiService serviceApi;
  PetRepositoryImpl(this.serviceApi);

  @override
  Future<PetListState> getByPet(String name) async {
    await Future.delayed(const Duration(seconds: 2));
    return serviceApi.fetchByPet(name);
  }

  @override
  Future<PetListState> getAllPet() async {
    await Future.delayed(const Duration(seconds: 2));
    return serviceApi.fetchAllPet();
  }
}
