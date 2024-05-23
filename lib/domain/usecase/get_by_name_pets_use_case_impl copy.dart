import '../../datasource/pet_repository_contract.dart';
import '../../presentarion/state/pet_list_state.dart';
import 'use_case_contract.dart';

class GetByNamePetsParams {
  final String name;

  const GetByNamePetsParams({
    required this.name,
  });
}

class GetByNamePetsUseCaseImpl
    implements IUseCase<PetListState, GetByNamePetsParams> {
  final IPetRepository _repository;

  GetByNamePetsUseCaseImpl({
    required IPetRepository repository,
  }) : _repository = repository;

  @override
  Future<PetListState> call(GetByNamePetsParams params) {
    return _repository.getByPet(params.name);
  }
}
