import 'package:adocao_animais/utils/app_routes.dart';
import 'package:flutter/material.dart';

class AlertLogin extends StatelessWidget {
  final String text;
  const AlertLogin(this.text);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Requer login'),
      content: Text(text),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Cancelar',
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.of(context).pushNamed(AppRoutes.LOGIN);
          },
          child: const Text('Fazer login'),
        )
      ],
    );
  }
}
