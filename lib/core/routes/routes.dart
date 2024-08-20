import 'package:asp_teste/domain/mappers/pet_mapper.dart';
import 'package:asp_teste/views/home.dart';
import 'package:asp_teste/views/pet_details/pet_details_view.dart';
import 'package:asp_teste/views/user/user_register.dart';
import 'package:go_router/go_router.dart';

abstract class RoutesApp {
  static final Route home = Route(name: 'home', path: '/');
  static final Route register =
      Route(name: 'register', path: '/user/user_register');
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
      builder: (context, state) => const MyHomePage(title: 'Login IFPR'),
    ),
    GoRoute(
      path: '/register', // Defina um nome para a rota de cadastro
      builder: (context, state) => const UserRegisterPage(),
    ),
  ],
);
