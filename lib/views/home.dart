import 'package:asp/asp.dart';
import 'package:asp_teste/core/routes/routes.dart';
import 'package:asp_teste/core/validators/max_lenght_str_validator%20copy.dart';
import 'package:asp_teste/domain/mappers/pet_mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../components/inpute_text_field.dart';
import '../core/errors/errors_classes.dart';
import '../core/errors/errors_messagens.dart';
import '../core/validators/min_lenght_str_validator.dart';
import '../core/validators/text_field_validator.dart';
import '../domain/entity/pet.dart';
import '../presentarion/pet_list/atom/pet_list_tom.dart';
import '../presentarion/state/pet_list_state.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // @override
  // void dispose() {
  //   super.dispose();
  //   _textSearchController.dispose();
  // }

  void _searchPets() {
    PetListStore.fetchAll();
  }

  void _alertNoResultDialog() {
    String msgError = 'Sem Resultado para Mostrar';
    if (PetListStore.atomAllPet.value is ErrorStateList) {
      msgError =
          ((PetListStore.atomAllPet.value as ErrorStateList).failure as Failure)
              .msg;
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: const Text('Erro Inesperado'),
          icon: Icon(
            Icons.cancel,
            color: Theme.of(context).colorScheme.error,
            size: 80.0,
          ),
          content: Text(msgError, textAlign: TextAlign.center),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    context.select(
      () => [
        PetListStore.loading,
        PetListStore.atomAllPet,
        PetListStore.atomPetByName,
      ],
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (PetListStore.atomAllPet.value is ErrorStateList &&
          !PetListStore.loading.value) {
        _alertNoResultDialog();
      }
    });

    return GestureDetector(
      onTap: (PetListStore.atomAllPet.value is ErrorStateList ||
              PetListStore.loading.value)
          ? null
          : () {
              // print(DateTime.now());
              SystemChannels.textInput.invokeMethod('TextInput.hide');
              // var f = FocusScope.of(context);

              // if (!f.hasPrimaryFocus) {
              //   f.unfocus();
              // }
            },
      child: Scaffold(
        appBar: AppBar(
          //backgroundColor: Theme.of(context).colorScheme.tertiary,
          title: Text(widget.title),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InputTextField(
                    label: 'Usuário',
                    textEditingController: _usernameController,
                    icon: Icons.person,
                    onValidator: (value) {
                      try {
                        var isValid = TextFieldValidator(validators: [
                          MinLengthStrValidator(minLength: 1),
                          MaxLengthStrValidator(),
                        ]).validations(value);

                        if (!isValid) {
                          return MessagesError.defaultError;
                        }

                        return null;
                      } on DefaultError catch (e) {
                        return e.msg;
                      } catch (e) {
                        return e.toString();
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InputTextField(
                    label: 'Senha',
                    textEditingController: _passwordController,
                    icon: Icons.lock,
                    onValidator: (value) {
                      try {
                        var isValid = TextFieldValidator(validators: [
                          MinLengthStrValidator(minLength: 1),
                          MaxLengthStrValidator(),
                        ]).validations(value);

                        if (!isValid) {
                          return MessagesError.defaultError;
                        }

                        return null;
                      } on DefaultError catch (e) {
                        return e.msg;
                      } catch (e) {
                        return e.toString();
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          Theme.of(context)
                              .colorScheme
                              .secondaryContainer), // Change button color
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      context.pushNamed(
                          'register'); // Navegação para a tela de cadastro
                    },
                    child: const Text(
                      'Cadastre-se',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ListPetsByName extends StatelessWidget {
  const ListPetsByName({
    super.key,
    required this.state,
  });

  final SuccessStateList state;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: <Widget>[
            const Text(
              'Resultado por nome',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: state.value.length,
                itemBuilder: (_, index) {
                  final pet = state.value[index] as Pet;
                  return CardItem(
                    item: pet,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListOfPets extends StatelessWidget {
  const ListOfPets({
    super.key,
    required this.state,
  });

  final SuccessStateList state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      //controller: scrollCont2,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: state.value.length,
      itemBuilder: (_, index) {
        final pet = state.value[index] as Pet;
        return CardItem(
          item: pet,
        );
      },
    );
  }
}

class CardItem extends StatelessWidget {
  final Pet item;
  const CardItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 4.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            stops: const [0.45, 0.95],
            colors: [
              Theme.of(context).colorScheme.secondaryContainer,
              Theme.of(context).colorScheme.secondary,
              // Color.fromARGB(255, 246, 239, 247),
              // Color.fromARGB(255, 241, 202, 248),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              item.nome[0],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            '${item.nome} (Id: ${item.id}) ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            item.raca,
          ),
          // trailing: InkWell(
          //   onTap: () => context.pushNamed(
          //     RoutesApp.petDetails.name,
          //     extra: PetMapper.fromEntityToJson(item),
          //   ),
          //   child: Icon(
          //     Icons.read_more,
          //     color: Theme.of(context).colorScheme.primaryContainer,
          //   ),
          // ),
        ),
      ),
    );
  }
}
