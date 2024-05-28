import '../../datasource/pet_repository_contract.dart';
import '../../presentarion/state/pet_list_state.dart';
import 'use_case_contract.dart';

// class GetAllPetsUseCaseImpl implements IUseCaseNoParams<PetListState> {
class GetAllPetsUseCaseImpl implements IUseCase<PetListState, NoParams> {
  final IPetRepository _repository;

  GetAllPetsUseCaseImpl({
    required IPetRepository repository,
  }) : _repository = repository;

  @override
 Future<PetListState> call(NoParams noParams) {
  // Future<PetListState> call() {
    return _repository.getAllPet();
  }
}
