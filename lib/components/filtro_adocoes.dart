import 'package:adocao_animais/models/adocao.dart';
import 'package:flutter/material.dart';

class FiltroAdocoes extends StatefulWidget {
  final Function(String) modifyAdocoes;
  const FiltroAdocoes(this.modifyAdocoes);

  @override
  State<FiltroAdocoes> createState() => _FiltroAdocoesState();
}

class _FiltroAdocoesState extends State<FiltroAdocoes> {
  List<String> filtro_option = <String>[
    'Todos',
    'em processo...',
    'aprovado',
    'rejeitado'
  ];

  String filtro = 'Todos';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 15, left: 15, top: 10),
      height: 95,
      child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (1 / .2),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: filtro_option.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: SizedBox.expand(
                  child: ElevatedButton(
                onPressed: () {
                  widget.modifyAdocoes(filtro_option[index]);
                  setState(() {
                    filtro = filtro_option[index];
                  });
                },
                child: Text(
                  filtro_option[index],
                  style: TextStyle(
                      color: filtro == filtro_option[index]
                          ? Colors.white
                          : Theme.of(context).colorScheme.secondary),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      filtro == filtro_option[index]
                          ? Theme.of(context).colorScheme.secondary
                          : Colors.white),
                ),
              )),
            );
          }),
    );
  }
}
