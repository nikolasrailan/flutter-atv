import 'package:asp_teste/components/inpute_text_field.dart';
import 'package:asp_teste/core/errors/errors_classes.dart';
import 'package:asp_teste/core/errors/errors_messagens.dart';
import 'package:asp_teste/core/routes/routes.dart';
import 'package:asp_teste/core/validators/max_lenght_str_validator%20copy.dart';
import 'package:asp_teste/core/validators/min_lenght_str_validator.dart';
import 'package:asp_teste/core/validators/text_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserRegisterPage extends StatefulWidget {
  const UserRegisterPage({super.key});

  @override
  State<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InputTextField(
                label: 'Email',
                textEditingController: _emailController,
                icon: Icons.email,
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
              InputTextField(
                label: 'Confirme sua senha',
                textEditingController: _confirmPasswordController,
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
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.go('/');
                    },
                    child: const Text('Voltar'),
                  ),
                  SizedBox(width: 50),
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
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
