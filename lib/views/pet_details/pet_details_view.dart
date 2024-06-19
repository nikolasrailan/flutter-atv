import 'package:asp/asp.dart';
import 'package:asp_teste/presentarion/state/pet_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/inpute_text_field.dart';
import '../../core/errors/errors_classes.dart';
import '../../core/errors/errors_messagens.dart';
import '../../core/masks/input_mask.dart';
import '../../core/masks/unit_metric_mask.dart';
import '../../core/routes/routes.dart';
import '../../core/validators/date_validator.dart';
import '../../core/validators/max_double_str_validator.dart';
import '../../core/validators/max_lenght_str_validator%20copy.dart';
import '../../core/validators/min_double_str_validator.dart';
import '../../core/validators/min_lenght_str_validator.dart';
import '../../core/validators/text_field_validator.dart';
import '../../domain/entity/pet.dart';
import '../../presentarion/pet_detail/atom/pet_detail_atom.dart';

class PetDetailsView extends StatefulWidget {
  final Pet pet;

  const PetDetailsView({super.key, required this.pet});

  @override
  State<PetDetailsView> createState() => _PetDetailsViewState();
}

class _PetDetailsViewState extends State<PetDetailsView> {
  final imageUrl =
      'https://upload.wikimedia.org/wikipedia/commons/4/43/Cute_dog.jpg';
  late bool initView;
  final _formKey = GlobalKey<FormState>();
  final _petNameFieldKey = GlobalKey<FormFieldState>();
  final _petNameFieldFocusNode = FocusNode();
  final _petNameController = TextEditingController();

  final _petDtNascController = TextEditingController();
  final _petDtNascFieldKey = GlobalKey<FormFieldState>();
  final _petDtNascFieldFocusNode = FocusNode();

  final _petPesoController = TextEditingController();
  final _petPesoFieldKey = GlobalKey<FormFieldState>();
  final _petPesoFieldFocusNode = FocusNode();

  @override
  void dispose() {
    _petNameController.dispose();
    _petNameFieldFocusNode.dispose();
    _petDtNascController.dispose();
    _petDtNascFieldFocusNode.dispose();
    _petPesoController.dispose();
    _petPesoFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    initView = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.select(
      () => [
        PetDetailStore.petEditingAtom,
        PetDetailStore.petLoadingAtom,
        PetDetailStore.petByIdAtom,
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pet.nome),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Column(
              children: <Widget>[
                cardPetDetail(context),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Habilitar Edição',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: PetDetailStore.petEditingAtom.value
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).textTheme.displayLarge?.color,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Switch(
                      value: initView
                          ? false
                          : PetDetailStore.togglePetEditingAction.value!,
                      onChanged: (value) {
                        PetDetailStore.togglePetEditingAction.value = value;
                        initView = false;
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    PetDetailStore.fetchPetById.setValue(widget.pet.id);
                    if (_formKey.currentState!.validate()) {
                      context.goNamed(RoutesApp.home.name);
                    }
                  },
                  child: !PetDetailStore.petLoadingAtom.value
                      ? PetDetailStore.petEditingAtom.value
                          ? const Text('habilitado')
                          : const Text('Desabilitado')
                      : const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: CircularProgressIndicator(),
                        ),
                ),
                if (PetDetailStore.petEditingAtom.value && !initView)
                  Container(
                    margin: const EdgeInsets.only(top: 20, right: 5, left: 5),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Theme.of(context).colorScheme.inversePrimary,
                        Theme.of(context).colorScheme.secondary,
                        Theme.of(context).colorScheme.inversePrimary,
                        Theme.of(context).colorScheme.onPrimary,
                      ],
                    )),
                    //color: Theme.of(context).colorScheme.secondary,
                    child: Column(
                      children: <Widget>[
                        InputTextField(
                          textEditingController: _petNameController,
                          label: 'Nome do Pet',
                          icon: Icons.pets,
                          focusNode: _petNameFieldFocusNode,
                          globalKey: _petNameFieldKey,
                          onFieldSubmitted: (value) {
                            if (!_petNameFieldKey.currentState!.validate()) {
                              FocusScope.of(context)
                                  .requestFocus(_petNameFieldFocusNode);
                            } else {
                              _petNameFieldFocusNode.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(_petDtNascFieldFocusNode);
                            }
                          },
                          onValidator: (value) {
                            try {
                              var isValid = TextFieldValidator(validators: [
                                MinLengthStrValidator(),
                                MaxLengthStrValidator(),
                              ]).validations(value);

                              if (!isValid) {
                                return MessagesError.defaultError;
                              }
                              return null;
                            } on Failure catch (e) {
                              return e.msg;
                            } catch (e) {
                              return e.toString();
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        InputTextField(
                          textEditingController: _petDtNascController,
                          label: 'Data de Nascimento',
                          hint: 'dd/mm/aaaa',
                          icon: Icons.cake,
                          keyboardType: TextInputType.number,
                          focusNode: _petDtNascFieldFocusNode,
                          globalKey: _petDtNascFieldKey,
                          onFieldSubmitted: (value) {
                            if (!_petDtNascFieldKey.currentState!.validate()) {
                              FocusScope.of(context)
                                  .requestFocus(_petDtNascFieldFocusNode);
                            } else {
                              _petNameFieldFocusNode.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(_petPesoFieldFocusNode);
                            }
                          },
                          onValidator: (value) {
                            try {
                              var isValid = TextFieldValidator(validators: [
                                DateValidator(),
                              ]).validations(value);

                              if (!isValid) {
                                return MessagesError.defaultError;
                              }
                              return null;
                            } on Failure catch (e) {
                              return e.msg;
                            } catch (e) {
                              return e.toString();
                            }
                          },
                          inputFormatters: [InputMask.dateMask],
                        ),
                        const SizedBox(height: 10),
                        InputTextField(
                          textEditingController: _petPesoController,
                          label: 'Peso do Pet',
                          hint: '0,0 Kg',
                          inputFormatters: [
                            MetricUnitInputFormatter(
                                unitMask: ' Kg.', decimals: 1)
                          ],
                          icon: Icons.wifi_protected_setup_outlined,
                          keyboardType: TextInputType.number,
                          focusNode: _petPesoFieldFocusNode,
                          globalKey: _petPesoFieldKey,
                          onFieldSubmitted: (value) {
                            if (!_petPesoFieldKey.currentState!.validate()) {
                              FocusScope.of(context)
                                  .requestFocus(_petPesoFieldFocusNode);
                            }
                            // } else {
                            //   FocusScope.of(context)
                            //       .requestFocus(_petPesoFieldFocusNode);
                            // }
                            _petNameFieldFocusNode.unfocus();
                          },
                          onValidator: (value) {
                            try {
                              if (value != null) {
                                value = value
                                    .replaceAll(' Kg.', '')
                                    .replaceAll('.', '')
                                    .replaceAll(',', '.')
                                    .replaceAll(' ', '');
                              }

                              var isValid = TextFieldValidator(validators: [
                                MinDoubleFromStrValidator(minValue: 0),
                                MaxDoubleFromStrValidator(maxValue: 10.0)
                              ]).validations(value);

                              if (!isValid) {
                                return MessagesError.defaultError;
                              }
                              return null;
                            } on Failure catch (e) {
                              return e.msg;
                            } catch (e) {
                              return e.toString();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cardPetDetail(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        margin: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              stops: const [0.20, 0.7],
              colors: [
                //Theme.of(context).colorScheme.secondaryContainer,
                Theme.of(context).colorScheme.tertiary,
                Theme.of(context).colorScheme.primary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Positioned(
                top: 10,
                right: 0,
                child: ClipOval(
                  child: Image.network(
                    imageUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.pet.nome,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryFixed,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Identificação (Id): ${widget.pet.id}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimaryFixed,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Raça: ${widget.pet.raca}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimaryFixed,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Peso: ${widget.pet.peso} kg',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimaryFixed,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Nascimento: ${formatDate(widget.pet.dtNascimento)}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimaryFixed,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
