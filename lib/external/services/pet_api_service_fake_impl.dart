import '../../core/errors/errors_classes.dart';
import '../../domain/entity/pet.dart';
import '../../helper/pet_fake_repository.dart';
import '../../presentarion/state/pet_list_state.dart';
import '../../presentarion/state/pet_state.dart';
import 'pet_api_contract.dart';

class PetServiceFakeApiImpl implements IPetApiService {
  PetsFakApiDataBase api;

  PetServiceFakeApiImpl(this.api);

  @override
  Future<PetListState> fetchByPet(String name) async {
    try {
      var result = await api.getByName(name);
      return SuccessStateList(result);
    } on DefaultError catch (e) {
      return ErrorStateList(e);
    } catch (e) {
      return ErrorStateList(e);
    }
  }

  @override
  Future<PetListState> fetchAllPet() async {
    try {
      var result = await api.getAllPet();
      return SuccessStateList(result);
    } on DefaultError catch (e) {
      return ErrorStateList(e);
    } catch (e) {
      return ErrorStateList(e);
    }
  }

  @override
  Future<PetState> fetchByIdPet(int idPet) async {
    try {
      var result = await api.getPetById(idPet);
      return SuccessState(result);
    } on InvalidSearchText catch (e) {
      return ErrorState(e);
    } on DatasourceResultEmpty catch (e) {
      return ErrorState(e);
    } catch (e) {
      return ErrorState(e);
    }
  }

  @override
  Future<PetState> updatePet(Pet pet) async {
    try {
      var result = await api.updatePet(pet);
      return SuccessState(result);
    } on PetNotFound catch (e) {
      return ErrorState(e);
    } on DefaultError catch (e) {
      return ErrorState(e);
    } catch (e) {
      return ErrorState(e);
    }
  }
}
