import 'package:adocao_animais/components/info_animal.dart';
import 'package:adocao_animais/models/adocao.dart';
import 'package:adocao_animais/repositories/adocoes_repository.dart';
import 'package:adocao_animais/repositories/usuario_repository.dart';
import 'package:adocao_animais/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdocaoIcon extends StatelessWidget {
  final Adocao adocao;
  final bool isDono;
  const AdocaoIcon(this.adocao, this.isDono);

  @override
  Widget build(BuildContext context) {
    var usuario = context.watch<UsuarioRepository>();
    var repository = context.watch<AdocoesRepository>();

    _openTaskFilterModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: InfoAnimal(adocao.animal),
          );
        });
  }

    return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                .pushNamed(
                  AppRoutes.ADOCAO_DETAIL,
                  arguments: adocao,
                );
              },
              onLongPress: (){
                _openTaskFilterModal(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(width: 1, color: Theme.of(context).colorScheme.secondary)
                ),
                width: 100,
                height: 100,
                child: Stack(children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          adocao.animal.img[0],
                          height: 100,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(adocao.usuario.nome, 
                              style: TextStyle(
                                fontSize: 16, 
                                color: Theme.of(context).colorScheme.primary, 
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(height: 10,),
                            // Row(                                          // dependendo do tamanho do email, sai da tela...
                            //   children: [
                            //     Icon(Icons.mail, size: 20,),
                            //     SizedBox(width: 10,),
                            //     Text(adocao.usuario.email, 
                            //       style: TextStyle(
                            //         fontSize: 13
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            Row(
                              children: [
                                Icon(Icons.smartphone, size: 20,),
                                SizedBox(width: 10,),
                                Text(adocao.usuario.telefone),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  Positioned(
                    child: Text(adocao.status,
                        style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
                    bottom: 0,
                    right: 10,
                  ),
                  isDono 
                  ?
                    Container()
                  :
                  Positioned(
                    child: IconButton(
                      color: Colors.white,
                      onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Cancelar adoção'),
                          content: const Text(
                              'Tem certeza que quer cancelar a adoção?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Não'),
                            ),
                            TextButton(
                              onPressed: () {
                                repository.deleteAdocao(adocao);
                                Navigator.of(context).pop();
                              },
                              child: Text('Sim'),
                            ),
                          ],
                        ),
                      ),
                      icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.secondary,),
                    ),
                    top: 0,
                    right: 0,
                  ),
                ]),
              ),
            ),
          );
  }
}