sealed class PetListState {
  const PetListState();
}
class InitialStateList extends PetListState {}

final class SuccessStateList<Pet> implements PetListState {
  const SuccessStateList(this.value);
  final List<Pet> value;
}

final class ErrorStateList<Failure> implements PetListState {
  const ErrorStateList(this.failure);
  final Failure failure;
}
