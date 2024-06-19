import 'package:asp_teste/domain/mappers/pet_mapper.dart';
import 'package:asp_teste/views/home.dart';
import 'package:asp_teste/views/pet_details/pet_details_view.dart';
import 'package:go_router/go_router.dart';

abstract class RoutesApp {
  static final Route home = Route(name: 'home', path: '/');
  static final Route petDetails = Route(name: 'petdetails', path: '/petdetails');
}

class Route {
  final String name;
  final String path;

  Route({required this.name, required this.path});
}

final GoRouter routers = GoRouter(
  routes: [
    GoRoute(
      name: RoutesApp.home.name,
      path: RoutesApp.home.path,
      builder: (context, state) => const MyHomePage(title: 'Meus Pets'),
    ),
    GoRoute(
      name: RoutesApp.petDetails.name,
      path: RoutesApp.petDetails.path,
      builder: (context, state) {
        //final petJson = state.extra as Map<String, dynamic>;
        final pet = PetMapper.fromJsonToEntity(state.extra as String);
        return PetDetailsView(pet: pet);
      },
    ),
  ],
);
