import 'package:asp/asp.dart';
import 'package:asp_teste/core/themes/themes.dart';
import 'package:asp_teste/core/validators/max_lenght_str_validator%20copy.dart';
import 'package:asp_teste/core/validators/min_lenght_str_validator.dart';
import 'package:asp_teste/core/validators/search_validator.dart';
import 'package:auto_injector/auto_injector.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'datasource/pet_repository_contract.dart';
import 'datasource/pet_repository_impl.dart';
import 'domain/usecase/get_all_pets_use_case_impl.dart';
import 'domain/usecase/get_by_name_pets_use_case_impl copy.dart';
import 'domain/usecase/use_case_contract.dart';
import 'external/services/pet_api_contract.dart';
import 'external/services/pet_api_service_fake_impl.dart';
import 'helper/pet_fake_repository.dart';
import 'presentarion/reducer/pet_list_reducer.dart';
import 'views/home.dart';

// const Color nubankPrimaryColor = Color(0xFF8A05BE);
// const Color nubankSecondaryColor = Color(0xFF820AD1);
// const Color nubankAccentColor = Color(0xFFB620E0);
final injector = GetIt.instance;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  injector.registerSingleton<PetsFakApiDataBase>(
      PetsFakApiDataBase(numInstance: 20));
  injector.registerFactory<IPetApiService>(
      () => PetServiceFakeApiImpl(injector<PetsFakApiDataBase>()));
  injector.registerFactory<IPetRepository>(
      () => PetRepositoryImpl(injector<IPetApiService>()));
  injector.registerFactory<IUseCase>(
      () => GetAllPetsUseCaseImpl(
            repository: injector<IPetRepository>(),
          ),
      instanceName: 'GetAllPet');
  injector.registerFactory<IUseCase>(
      () => GetByNamePetsUseCaseImpl(
            repository: injector<IPetRepository>(),
          ),
      instanceName: 'GetByNamePet');

  injector.registerSingleton<PetListReducer>(PetListReducer(
    getAllPetsUseCase: injector<IUseCase>(instanceName: 'GetAllPet'),
    getByNameUseCase: injector<IUseCase>(instanceName: 'GetByNamePet'),
  ));

 
  // var injector = AutoInjector();
  // injector.addInstance<PetsFakApiDataBase>(PetsFakApiDataBase(numInstance: 20));
  // injector.add<IPetApiService>(PetServiceFakeApiImpl.new);
  // injector.add<IPetRepository>(PetRepositoryImpl.new);
  // injector.add<IUseCaseNoParams>(GetAllPetsUseCaseImpl.new);
  // injector.add<IUseCase>(GetByNamePetsUseCaseImpl.new);
  // // injector.addSingleton<PetListReducer>(
  // //   (i) => PetListReducer(
  // //     (injector.get<IUseCaseNoParams>(key: 'GetAll')),
  // //     (injector.get<IUseCase>(key: 'GetName')),
  // //   ),
  // // );
  // injector.addSingleton<PetListReducer>(PetListReducer.new);
  // //injector.addSingleton<PetReducer>(PetReducer.new);
  // injector.commit();
  runApp(
    RxRoot(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: myTheme,
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(
        //     seedColor: nubankPrimaryColor,
        //     primary: nubankPrimaryColor,
        //     secondary: nubankSecondaryColor,
        //     tertiary: nubankAccentColor,
        //     brightness: Brightness.light,
        //   ),
        //   useMaterial3: true,
        // ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    ),
  );
}
