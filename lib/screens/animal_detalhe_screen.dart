import 'package:flutter/material.dart';
import '../models/animal.dart';

class AnimalDetalheScreen extends StatelessWidget {
  final Animal animal;

  AnimalDetalheScreen(this.animal);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(animal.nome), // Nome do animal como título da página
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                child: Image.network(
                  animal.img,
                  fit: BoxFit.cover,
                )), // Foto do animal
            Text('Tipo: ${animal.tipo}'),
            Text('Porte: ${animal.porte}'),
            Text('Sexo: ${animal.sexo}'),
            Text('Idade: ${animal.idade}'),
            Text('Raça: ${animal.raca}'),
            Text('Descrição: ${animal.descricao}'),
          ],
        ),
      ),
    );
  }
}
