import 'package:asp/asp.dart';

import '../../../domain/usecase/get_by_name_pets_use_case_impl copy.dart';
import '../../../domain/usecase/use_case_contract.dart';
import '../atom/pet_list_tom.dart';
import '../../state/pet_list_state.dart';

class PetListReducer extends Reducer {
  final IUseCase getAllPetsUseCase;
  // final IUseCaseNoParams getAllPets;
  final IUseCase getByNameUseCase;

  PetListReducer({
    required this.getAllPetsUseCase,
    required this.getByNameUseCase,
  }) {
    on(() => [PetListStore.fetchAll], _fetchPetAll);
    on(() => [PetListStore.fetchByName], _fetchByName);
    on(() => [PetListStore.cleanView], _cleanView);
  }

  _fetchPetAll() async {
    PetListStore.loading.setValue(true);
    // PetListStore.atomAllPet.value = await getAllPets();
    PetListStore.atomAllPet.value = await getAllPetsUseCase(NoParams());
    PetListStore.loading.setValue(false);
  }

  _fetchByName() async {
    PetListStore.loading.setValue(true);
    PetListStore.atomPetByName.value = await getByNameUseCase.call(
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
