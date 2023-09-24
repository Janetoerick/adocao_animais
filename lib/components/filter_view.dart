import 'package:flutter/material.dart';

class FilterView extends StatelessWidget {
  final String tipo;
  final Function() onSubmit;
  const FilterView(this.tipo, this.onSubmit);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8),
      height: 26,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.tertiary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(tipo, style: TextStyle(fontWeight: FontWeight.bold)),
          IconButton(
              padding: EdgeInsets.only(bottom: 0.5),
              onPressed: () {
                onSubmit();
              },
              icon: Icon(
                Icons.highlight_remove,
                size: 18,
              ))
        ],
      ),
    );
  }
}
