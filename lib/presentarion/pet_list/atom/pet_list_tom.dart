import 'package:asp/asp.dart';

import '../../state/pet_list_state.dart';

// atom
// final petLoading = Atom<bool>(false);
// final petAtom = Atom<PetState>(InitialState());
// // final petAtom = Atom<PetState?>(null);

// // actions
// final fetchPet = Atom.action();

abstract class PetListStore {
// atom
  static final loading = Atom(false);
  static final atomAllPet = Atom<PetListState>(InitialStateList());
  static final atomPetByName = Atom<PetListState>(InitialStateList());

// actions
  static final fetchAll = Atom.action();
  static final cleanView = Atom.action();
  static final fetchByName = Atom<String>('');
}
