import 'package:adocao_animais/components/favorite_button.dart';
import 'package:adocao_animais/models/animal.dart';
import 'package:adocao_animais/repositories/adocoes_repository.dart';
import 'package:adocao_animais/repositories/animais_repository.dart';
import 'package:adocao_animais/repositories/usuario_repository.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InfoAnimal extends StatefulWidget {
  final Animal animal;
  const InfoAnimal(this.animal);

  @override
  State<InfoAnimal> createState() => _InfoAnimalState();
}

class _InfoAnimalState extends State<InfoAnimal> {
  late PageController _pageController;
  int activePage = 0;
  
  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8, initialPage : activePage);
  }

  List<Widget> indicators(imagesLength,currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.black26,
            shape: BoxShape.circle),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UsuarioRepository>(context, listen: false).usuario;
    Animal animal = Provider.of<AnimaisRepository>(context, listen: false).findByid(widget.animal.id);
    var adocoes = Provider.of<AdocoesRepository>(context, listen: false);
    return SizedBox(
            height: MediaQuery.of(context).size.height * 0.85,
            child: SingleChildScrollView(
              child: Column(
                children: [
                Column(
                  children: [
                    Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child: PageView.builder(
                        pageSnapping: true,
                        itemCount: animal.img.length,
                        controller: _pageController,
                        onPageChanged: (page) {
                          setState(() {
                            activePage = page;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.all(10),
                            child: Image.network(
                              animal.img[index],
                              fit: BoxFit.contain,
                            ));
                        },
                        ),
                    ),
                    animal.img.length > 1 ?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: indicators(animal.img.length, activePage)
                      )
                    : Container()
                  ],
                ), // Foto do animal
                
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // (animal.novo)
                      // ? Container(
                      //     child: Container(
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(10),
                      //         color: Theme.of(context).colorScheme.tertiary,
                      //       ),
                      //       width: 50,
                      //       alignment: Alignment.center,
                      //       child: Text(
                      //         "Novo",
                      //         style: TextStyle(fontWeight: FontWeight.bold),
                      //       ),
                      //     ),
                      //   )
                      // : Container(),
                      Container(
                        height: 90,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 238, 238, 238)
                        ),
                        padding: EdgeInsets.only(top: 12, bottom: 12, right: 20, left: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    animal.nome,
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
                                      animal.sexo == 'Macho' ?
                                        Color.fromARGB(255, 94, 176, 243)
                                      :
                                        Color.fromARGB(255, 245, 97, 146)
                                    ),
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      '${animal.sexo}, ${animal.idade}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ]
                              ),
                            ),
                            user.login != animal.dono.login ?
                            FavoriteButton(
                              animal: animal,
                              size: 40,
                            )
                              
                            : Container(),
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
                                Text(animal.raca, style: TextStyle(fontSize: 20),),
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
                                Text(animal.porte, style: TextStyle(fontSize: 20),),
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
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      animal.descricao, 
                                      style: TextStyle(
                                        fontSize: 20),
                                    )
                                  ),
                                ),
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
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      animal.dono.login == user.login || adocoes.inUserAdocoes(animal, user.login)?
                                      user.email
                                      :
                                      'Para saber o email de contato, entre em processo de adoção', 
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: 
                                        animal.dono.login == user.login || adocoes.inUserAdocoes(animal, user.login)?
                                        Colors.black
                                        :
                                        Theme.of(context).colorScheme.secondary),)),
                                ),
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
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      animal.dono.login == user.login || adocoes.inUserAdocoes(animal, user.login)?
                                      user.telefone
                                      :
                                      'Para saber o telefone de contato, entre em processo de adoção', 
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: 
                                        animal.dono.login == user.login || adocoes.inUserAdocoes(animal, user.login)?
                                        Colors.black
                                        :
                                          Theme.of(context).colorScheme.secondary),)),
                                ),
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