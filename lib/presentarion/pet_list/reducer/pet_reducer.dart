import 'package:asp/asp.dart';

import '../../../domain/usecase/get_by_name_pets_use_case_impl copy.dart';
import '../../../domain/usecase/use_case_contract.dart';
import '../atom/pet_atom.dart';

class PetReducer extends Reducer {
  final IUseCase useCaseByName;

  PetReducer(this.useCaseByName) {
    on(() => [PetStore.fetch], _fetchPet);
    // on(() => [fetchPet], _fetchPet);
  }

  _fetchPet() async {
    PetStore.loading.setValue(true);
    PetStore.atom.value = await useCaseByName.call(
      GetByNamePetsParams(name: PetStore.fetch.value),
    );
    PetStore.loading.setValue(false);
  }

  // _fetchPet() async {
  //   petLoading.setValue(true);
  //   petAtom.value = await repository.getPet();
  //   petLoading.setValue(false);
  // }
}
