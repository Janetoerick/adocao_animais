import 'package:flutter/material.dart';

class DefaultView extends StatelessWidget {
  final String text;
  const DefaultView(this.text);
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Positioned(
          child: Image.asset(
        'lib/assets/patas.png',
        height: 150,
        width: 150,
        color: Color.fromARGB(255, 233, 233, 233),
      )),
      SizedBox(
        width: 250,
        child: Text(text,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary),
            textAlign: TextAlign.center),
      ),
    ]);
  }
}
