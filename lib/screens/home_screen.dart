import 'package:adocao_animais/components/lista_adocoes.dart';
import 'package:flutter/material.dart';

import '../models/adocao.dart';
import '../models/animal.dart';

class HomeScreen extends StatelessWidget {
  final List<Adocao> adocoes;
  final Function(Animal) onSubmit;
  const HomeScreen(this.adocoes, this.onSubmit);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adote Petz"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text('Que tal adotar?',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold)),
                        Text(
                          'Diz que sim',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      'lib/assets/dog_and_cat.png',
                      width: 140,
                      height: 140,
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Animais em fase de adoção:',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            (adocoes.isEmpty)
                ? Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(alignment: Alignment.center, children: [
                          Positioned(
                              child: Image.asset(
                            'lib/assets/patas.png',
                            height: 150,
                            width: 150,
                            color: Color(0xffcbcbcb),
                          )),
                          SizedBox(
                            width: 250,
                            child: Text(
                                'Você não está em processos de adoção no momento...',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                textAlign: TextAlign.center),
                          ),
                        ]),
                      ],
                    ),
                  )
                : ListaAdocoes(adocoes, onSubmit)
          ],
        ),
      ),
    );
  }
}
