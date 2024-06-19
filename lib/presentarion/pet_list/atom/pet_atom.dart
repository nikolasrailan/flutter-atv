import 'package:asp/asp.dart';

import '../../state/pet_list_state.dart';

// atom
// final petLoading = Atom<bool>(false);
// final petAtom = Atom<PetState>(InitialState());
// // final petAtom = Atom<PetState?>(null);

// // actions
// final fetchPet = Atom.action();



abstract class PetStore {
// atom
  static final loading = Atom(false);
  static final atom = Atom<PetListState>(InitialStateList());

// actions
  static final fetch = Atom<String>('');
}
