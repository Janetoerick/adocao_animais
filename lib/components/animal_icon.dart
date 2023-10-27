import 'package:adocao_animais/repositories/animais_repository.dart';
import 'package:flutter/material.dart';
import 'package:adocao_animais/models/animal.dart';
import 'package:adocao_animais/screens/animal_detalhe_screen.dart';
import 'package:provider/provider.dart';

class AnimalIcon extends StatelessWidget {
  final Animal animal;

  const AnimalIcon(this.animal);

  void _selectAnimal(BuildContext context) {
    Navigator.of(context)
        .pushNamed(
          '/detalhe_screen',
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
                    ],
                  ),
                ),
              ),
            );
  }
}
