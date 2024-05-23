import 'package:asp/asp.dart';
import 'package:auto_injector/auto_injector.dart';
import 'package:flutter/material.dart';

import 'datasource/pet_repository_contract.dart';
import 'datasource/pet_repository_impl.dart';
import 'domain/usecase/get_by_name_pets_use_case_impl copy.dart';
import 'helper/pet_fake_repository.dart';
import 'views/home.dart';
import 'external/services/pet_api_contract.dart';
import 'external/services/pet_api_service_fake_impl.dart';
import 'presentarion/reducer/pet_list_reducer.dart';
import 'domain/usecase/get_all_pets_use_case_impl.dart';
import 'domain/usecase/use_case_contract.dart';

const Color nubankPrimaryColor = Color(0xFF8A05BE);
const Color nubankSecondaryColor = Color(0xFF820AD1);
const Color nubankAccentColor = Color(0xFFB620E0);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  var injector = AutoInjector();
  injector.addInstance<PetsFakApiDataBase>(PetsFakApiDataBase(numInstance: 20));
  injector.add<IPetApiService>(PetServiceFakeApiImpl.new);
  injector.add<IPetRepository>(PetRepositoryImpl.new);
  injector.add<IUseCaseNoParams>(GetAllPetsUseCaseImpl.new);
  injector.add<IUseCase>(GetByNamePetsUseCaseImpl.new);
  //injector.addSingleton<PetReducer>(PetReducer.new);
  injector.addSingleton<PetListReducer>(PetListReducer.new);
  injector.commit();
  runApp(
    RxRoot(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: nubankPrimaryColor,
            primary: nubankPrimaryColor,
            secondary: nubankSecondaryColor,
            tertiary: nubankAccentColor,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    ),
  );
}
