import '../../datasource/pet_repository_contract.dart';
import '../../presentarion/state/pet_state.dart';
import 'use_case_contract.dart';

class GetByIdPetParams {
  final int idPet;

  const GetByIdPetParams({
    required this.idPet,
  });
}

class GetByIdPetUseCaseImpl implements IUseCase<PetState, GetByIdPetParams> {
  final IPetRepository _repository;

  GetByIdPetUseCaseImpl({
    required IPetRepository repository,
  }) : _repository = repository;

  @override
  Future<PetState> call(GetByIdPetParams params) {
    return _repository.getByIdPet(params.idPet);
  }
}
