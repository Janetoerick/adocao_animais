import '../models/animal.dart';
import '../components/favorite_button.dart';
import 'package:flutter/material.dart';

class AnimalDetalheScreen extends StatefulWidget {
  final Animal animal;
  AnimalDetalheScreen(this.animal);
  @override
  _AnimalDetalheScreenState createState() => _AnimalDetalheScreenState();
}

class _AnimalDetalheScreenState extends State<AnimalDetalheScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.animal.nome), // Nome do animal como título da página
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                child: Image.network(
                  widget.animal.img,
                  fit: BoxFit.cover,
                )), // Foto do animal
            Text('Tipo: ${widget.animal.tipo}'),
            Text('Porte: ${widget.animal.porte}'),
            Text('Sexo: ${widget.animal.sexo}'),
            Text('Idade: ${widget.animal.idade}'),
            Text('Raça: ${widget.animal.raca}'),
            Text('Descrição: ${widget.animal.descricao}'),
            Positioned(
              // Posição do botão de favorito
              bottom: 100,
              right: 100,
              // Tamanho do botão de favorito
              width: 100,
              height: 100,
              child: FavoriteButton(
                animal: widget.animal,
                onChanged: (bool isFavorito) {
                  setState(() {
                    widget.animal.isFavorito = isFavorito;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
