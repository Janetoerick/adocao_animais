import 'dart:html';

import 'package:flutter/material.dart';

class FiltroAnimais extends StatefulWidget {
  Function(String) onSubmit;
  FiltroAnimais(this.onSubmit);

  _FiltroAnimais createState() => _FiltroAnimais();
}

class _FiltroAnimais extends State<FiltroAnimais> {
  List<String> list = <String>['', 'Cachorro', 'Gato', 'Papagaio'];
  String dropdownValue = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 250,
            height: 60,
            child: DropdownButton<String>(
              isExpanded: true,
              value: dropdownValue,
              elevation: 16,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 16,
              ),
              padding: EdgeInsets.all(8),
              onChanged: (String? value) => {
                setState(() {
                  dropdownValue = value!;
                })
              },
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          SizedBox(
            width: 200,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                widget.onSubmit(dropdownValue);
              },
              child: Text(
                "Filtrar",
                style: TextStyle(fontSize: 16),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.secondary)),
            ),
          )
        ],
      ),
    );
  }
}
