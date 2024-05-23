sealed class PetState {
  const PetState();
}
class InitialState extends PetState {}

final class SuccessState<Pet> implements PetState {
  const SuccessState(this.value);
  final Pet value;
}

final class ErrorState<Failure> implements PetState {
  const ErrorState(this.failure);
  final Failure failure;
}
