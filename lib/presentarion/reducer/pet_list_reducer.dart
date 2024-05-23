import 'package:asp/asp.dart';
import 'package:asp_teste/domain/usecase/use_case_contract.dart';

import '../../datasource/pet_repository_contract.dart';
import '../../domain/usecase/get_by_name_pets_use_case_impl copy.dart';
import '../atom/pet_list_tom.dart';
import '../state/pet_list_state.dart';

class PetListReducer extends Reducer {
  final IUseCaseNoParams getAllPets;
  final IUseCase useCaseByName;

  PetListReducer(
    this.getAllPets,
    this.useCaseByName,
  ) {
    on(() => [PetListStore.fetchAll], _fetchPetAll);
    on(() => [PetListStore.fetchByName], _fetchByName);
    on(() => [PetListStore.cleanView], _cleanView);
  }

  _fetchPetAll() async {
    PetListStore.loading.setValue(true);
    PetListStore.atomAllPet.value = await getAllPets();
    PetListStore.loading.setValue(false);
  }

  _fetchByName() async {
    PetListStore.loading.setValue(true);
    PetListStore.atomPetByName.value = await useCaseByName.call(
      GetByNamePetsParams(name: PetListStore.fetchByName.value),
    );
    PetListStore.loading.setValue(false);
  }

  _cleanView() {
    PetListStore.loading.setValue(true);
    PetListStore.atomAllPet.value = InitialStateList();
    PetListStore.atomPetByName.value = InitialStateList();
    PetListStore.loading.setValue(false);
  }

  // _fetchPet() async {
  //   petLoading.setValue(true);
  //   petAtom.value = await repository.getPet();
  //   petLoading.setValue(false);
  // }
}
