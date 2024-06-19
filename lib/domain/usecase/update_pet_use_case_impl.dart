import '../../datasource/pet_repository_contract.dart';
import '../../presentarion/state/pet_state.dart';
import '../entity/pet.dart';
import 'use_case_contract.dart';

class UpdatePetParams {
  final Pet pet;

  const UpdatePetParams({
    required this.pet,
  });
}

class UpdatePetsUseCaseImpl
    implements IUseCase<PetState, UpdatePetParams> {
  final IPetRepository _repository;

  UpdatePetsUseCaseImpl({
    required IPetRepository repository,
  }) : _repository = repository;

  @override
  Future<PetState> call(UpdatePetParams params) {
    return _repository.updatePet(params.pet);
  }
}
