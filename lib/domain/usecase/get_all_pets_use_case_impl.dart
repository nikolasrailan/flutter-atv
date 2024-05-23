import 'package:asp_teste/datasource/pet_repository_contract.dart';
import 'package:asp_teste/presentarion/state/pet_list_state.dart';
import 'package:asp_teste/domain/usecase/use_case_contract.dart';

class GetAllPetsUseCaseImpl implements IUseCaseNoParams<PetListState> {
  final IPetRepository _repository;

  GetAllPetsUseCaseImpl({
    required IPetRepository repository,
  }) : _repository = repository;

  @override
  Future<PetListState> call() {
    return _repository.getAllPet();
  }
}
