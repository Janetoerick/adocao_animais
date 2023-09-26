import 'package:flutter/material.dart';

import '../models/adocao.dart';
import '../models/animal.dart';

class ListaAdocoes extends StatelessWidget {
  final List<Adocao> adocoes;
  final Function(Animal) onSubmit;
  const ListaAdocoes(this.adocoes, this.onSubmit);

  void _selectAnimal(BuildContext context, int index) {
    Navigator.of(context)
        .pushNamed(
          '/detalhe_screen',
          arguments: adocoes[index].animal,
        )
        .then((value) => null);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: adocoes.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  _selectAnimal(context, index);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary,
                    // Color(0x1f8a8a8a)
                  ),
                  width: 100,
                  height: 100,
                  child: Stack(children: [
                    Image.network(
                      adocoes[index].animal.img,
                      height: 100,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      child: Text(adocoes[index].status,
                          style: TextStyle(color: Colors.white)),
                      bottom: 0,
                      right: 10,
                    ),
                    Positioned(
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () => showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Cancelar adoção'),
                            content: const Text(
                                'Tem certeza que quer cancelar a adoção?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Não'),
                              ),
                              TextButton(
                                onPressed: () {
                                  onSubmit(adocoes[index].animal);
                                  Navigator.of(context).pop();
                                },
                                child: Text('Sim'),
                              ),
                            ],
                          ),
                        ),
                        icon: Icon(Icons.delete),
                      ),
                      top: 0,
                      right: 5,
                    ),
                  ]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
