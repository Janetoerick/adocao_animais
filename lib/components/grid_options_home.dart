import 'package:flutter/material.dart';

class GridOptionsHome extends StatelessWidget {
  const GridOptionsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(10),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: [
        Container(
          height: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/form_animal');
            },
            child: Center(
              child: ListView(
                children: [
                  Icon(Icons.pets,),
                  Text('Registrar pet',),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}