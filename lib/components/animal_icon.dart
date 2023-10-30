import 'package:adocao_animais/components/info_animal.dart';
import 'package:adocao_animais/repositories/animais_repository.dart';
import 'package:adocao_animais/repositories/usuario_repository.dart';
import 'package:adocao_animais/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:adocao_animais/models/animal.dart';
import 'package:adocao_animais/screens/animal_detalhe_screen.dart';
import 'package:provider/provider.dart';

class AnimalIcon extends StatelessWidget {
  final Animal animal;
  final bool gerenciar;

  const AnimalIcon(this.animal, this.gerenciar);

  void _selectAnimal(BuildContext context) {
    Navigator.of(context)
        .pushNamed(
          AppRoutes.ANIMAL_DETAIL,
          arguments: animal,
        )
        .then((value) => null);
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: GestureDetector(
                onTap: () {
                  // Navegação para a tela de detalhes do animal
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => AnimalDetalheScreen(animais[index]),
                  //   ),
                  // );
                  _selectAnimal(context);
                },
                child: Container(
                  height: 100,
                  color: Color(0x1f8a8a8a),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Image.network(
                            animal.img[0],
                            height: 100,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                          (animal.novo)
                              ? Positioned(
                                  child: Container(
                                    color: Theme.of(context).colorScheme.tertiary,
                                    child: Text("Novo"),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  animal.nome,
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${animal.sexo} / ${animal.porte}',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.secondary,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  '${animal.idade}',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.secondary,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                              ),
                            ),
                            gerenciar 
                            ?
                            Positioned(
                              top: 0,
                              right: 0,
                              child: PopupMenuButton(
                              icon: Icon(
                                Icons.more_vert,
                              ),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: ListTile(
                                    title: Row(
                                      children: [
                                        Icon(Icons.edit),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Text('Editar'),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                      Navigator.of(context).pushNamed(
                                          AppRoutes.FORM_ANIMAL,
                                          arguments: animal);
                                    },
                                  ),
                                ),
                                PopupMenuItem(
                                  child: ListTile(
                                    title: Row(
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Excluir',
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                      final snackBar = SnackBar(
                                        content:
                                            const Text('Tem certeza que deseja excluir?'),
                                        action: SnackBarAction(
                                          label: 'Sim',
                                          onPressed: () {
                                            Provider.of<UsuarioRepository>(context, listen: false).removeMeusAnimais(animal);
                                            Provider.of<AnimaisRepository>(context, listen: false).removeAnimal(animal);
                                            final snackBarConfrim = SnackBar(
                                              content: const Text(
                                                  'Pet exlucido com sucesso!'),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBarConfrim);
                                          },
                                        ),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    },
                                  ),
                                ),
                              ],
                            ),)
                            : 
                            Container()
                          ]
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
  }
}
