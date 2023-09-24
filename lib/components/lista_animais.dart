import 'package:flutter/material.dart';
import 'package:adocao_animais/models/animal.dart';
import 'package:adocao_animais/screens/animal_detalhe_screen.dart';

class ListaAnimais extends StatelessWidget {
  final List<Animal> animais;

  const ListaAnimais(this.animais);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: animais.length,
      itemBuilder: (ctx, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: GestureDetector(
            onTap: () {
              // Navegação para a tela de detalhes do animal
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AnimalDetalheScreen(animais[index]),
                ),
              );
            },
            child: Container(
              height: 100,
              color: Color(0x1f8a8a8a),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Image.network(
                        animais[index].img,
                        height: 100,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                      (animais[index].novo)
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
                          animais[index].nome,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${animais[index].sexo} / ${animais[index].porte}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          '${animais[index].idade}',
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
      },
    );
  }
}
