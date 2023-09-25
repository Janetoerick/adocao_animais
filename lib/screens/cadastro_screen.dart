import 'package:flutter/material.dart';

class CadastroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Telefone'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'CPF'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Login'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                // Implemente a lógica de cadastro aqui
              },
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
