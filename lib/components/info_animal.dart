import 'package:adocao_animais/components/favorite_button.dart';
import 'package:adocao_animais/models/animal.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class InfoAnimal extends StatefulWidget {
  final Animal animal;
  const InfoAnimal(this.animal);

  @override
  State<InfoAnimal> createState() => _InfoAnimalState();
}

class _InfoAnimalState extends State<InfoAnimal> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            height: MediaQuery.of(context).size.height * 0.83,
            child: SingleChildScrollView(
              child: Column(children: [
                Stack(children: [
                  Container(
                      alignment: Alignment.center,
                      child: Image.network(
                        widget.animal.img[0],
                        fit: BoxFit.cover,
                        height: 250,
                      )),
                  Positioned(
                    top: 10,
                    right: 30,
                    child: FavoriteButton(
                        animal: widget.animal,
                        onChanged: (bool isFavorito) {
                          setState(() {
                            widget.animal.isFavorito = isFavorito;
                          });
                        }),
                  ),
                  (widget.animal.novo)
                      ? Positioned(
                          top: 10,
                          left: 30,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                            width: 50,
                            alignment: Alignment.center,
                            child: Text(
                              "Novo",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      : Container()
                ]), // Foto do animal
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 85,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 238, 238, 238)
                        ),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.animal.nome,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: GoogleFonts.oswald().fontFamily
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: 
                                      widget.animal.sexo == 'Macho' ?
                                        Color.fromARGB(255, 94, 176, 243)
                                      :
                                        Color.fromARGB(255, 245, 97, 146)
                                    ),
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      '${widget.animal.sexo}, ${widget.animal.idade}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ]
                              ),
                            ),
                            Icon(Icons.favorite_border, size: 50,),
                          ]
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 238, 238, 238)
                        ),
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.pets, size: 30,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 20),
                                  child: Container(
                                    width: 1,
                                    height: 30,
                                    color: Colors.black45,
                                  ),
                                ),
                                Text(widget.animal.raca, style: TextStyle(fontSize: 20),),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Icon(Icons.height, size: 30,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 20),
                                  child: Container(
                                    width: 1,
                                    height: 30,
                                    color: Colors.black45,
                                  ),
                                ),
                                Text(widget.animal.porte, style: TextStyle(fontSize: 20),),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Icon(Icons.search, size: 30,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 20),
                                  child: Container(
                                    width: 1,
                                    height: 30,
                                    color: Colors.black45,
                                  ),
                                ),
                                Text(widget.animal.descricao, style: TextStyle(fontSize: 20),),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Icon(Icons.mail, size: 30,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 20),
                                  child: Container(
                                    width: 1,
                                    height: 30,
                                    color: Colors.black45,
                                  ),
                                ),
                                Text(widget.animal.dono.email, style: TextStyle(fontSize: 20),),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Icon(Icons.phone_android, size: 30,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 20),
                                  child: Container(
                                    width: 1,
                                    height: 30,
                                    color: Colors.black45,
                                  ),
                                ),
                                Text(widget.animal.dono.telefone, style: TextStyle(fontSize: 20),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          );
  }
}