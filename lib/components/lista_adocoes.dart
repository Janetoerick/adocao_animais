import 'package:adocao_animais/repositories/usuario_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/adocao.dart';
import '../models/animal.dart';

class ListaAdocoes extends StatefulWidget {
  const ListaAdocoes();

  @override
  State<ListaAdocoes> createState() => _ListaAdocoesState();
}

class _ListaAdocoesState extends State<ListaAdocoes> {

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UsuarioRepository>();

    return Expanded(
      child: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: user.adocoes.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
        .pushNamed(
          '/detalhe_screen',
          arguments: user.adocoes[index].animal,
        );
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
                      user.adocoes[index].animal.img[0],
                      height: 100,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      child: Text(user.adocoes[index].status,
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
                                  user.attAdocoes(user.adocoes[index].animal);
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
