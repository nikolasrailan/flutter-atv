import 'package:asp/asp.dart';
import 'package:flutter/material.dart';

import '../core/errors/errors_classes.dart';
import '../domain/entity/pet.dart';
import '../presentarion/atom/pet_list_tom.dart';
import '../presentarion/state/pet_list_state.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void dispose() {
    super.dispose();
  }

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
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: const Text('Erro Inesperado'),
          icon: const Icon(
            Icons.cancel,
            color: Colors.red,
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _searchPets,
                    child: PetListStore.loading.value
                        ? const CircularProgressIndicator()
                        : const Text(
                            'Buscar Nomes',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: PetListStore.atomAllPet.value is SuccessStateList
                        ? () => PetListStore.fetchByName.setValue('a')
                        : null,
                    icon: const Icon(Icons.search),
                    color: Theme.of(context).colorScheme.primary,
                    iconSize: 40,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              switch (PetListStore.atomAllPet.value) {
                InitialStateList() => const Text('Clique no Botão Buscar'),
                (SuccessStateList state) =>
                  Expanded(child: ListOfPets(state: state)),
                ErrorStateList() => Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.cancel,
                          size: 70.0,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Teste Novamente',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
              },
              if (PetListStore.atomPetByName.value is ErrorStateList)
                Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.cancel,
                          size: 70.0,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Sem Resultados!!!',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    )),
              if (PetListStore.atomPetByName.value is SuccessStateList)
                ListPetsByName(
                  state: (PetListStore.atomPetByName.value as SuccessStateList),
                )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Limpar'),
        onPressed: PetListStore.cleanView,
        tooltip: 'Increment',
        icon: const Icon(Icons.clear),
      ), // This trailing comma makes auto-formatting nicer for build methods.
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
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 246, 239, 247),
              Color.fromARGB(255, 241, 202, 248),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.purple,
            child: Text(
              item.nome[0],
              style: const TextStyle(color: Colors.white),
            ),
          ),
          title: Text(
            item.nome,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            item.raca,
          ),
        ),
      ),
    );
  }
}
