import 'package:adocao_animais/components/alert_login.dart';
import 'package:adocao_animais/components/favorite_button.dart';
import 'package:adocao_animais/components/info_animal.dart';
import 'package:adocao_animais/models/usuario.dart';
import 'package:adocao_animais/repositories/adocoes_repository.dart';
import 'package:adocao_animais/repositories/animais_repository.dart';
import 'package:adocao_animais/repositories/usuario_repository.dart';
import 'package:adocao_animais/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/animal.dart';
import '../data/my_data.dart';

class AnimalDetalheScreen extends StatefulWidget {
  const AnimalDetalheScreen();

  @override
  State<AnimalDetalheScreen> createState() => _AnimalDetalheScreenState();
}

class _AnimalDetalheScreenState extends State<AnimalDetalheScreen> {

  @override
  Widget build(BuildContext context) {
    
    final animalRoute = ModalRoute.of(context)?.settings.arguments == null
        ? animaisData[0] // Tava dando null quando atualizava a página
        : ModalRoute.of(context)!.settings.arguments as Animal;
    
    var usuario = context.watch<UsuarioRepository>();
    var adocoes = context.watch<AdocoesRepository>();

    // Para caso o dono queira editar o animal na pagina de detalhes... (ir as info do animal para tela de edit atualizada)
    Animal animal;
    var animalRepository = Provider.of<AnimaisRepository>(context, listen: false); 
    if(animalRepository.isDonoAnimal(animalRoute)){
      animal = usuario.findMeuAnimalByAnimal(animalRoute);
    } else {
      animal = animalRepository.findByid(animalRoute.id);
    }


    return Scaffold(
      appBar: AppBar(
        title: Text('Adote ${animal.nome}!'), 
        actions: 
        animal.dono.login == usuario.usuario.login ?
        [
          IconButton(onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.FORM_ANIMAL, arguments: animal);
          }, icon: Icon(Icons.edit)),
          IconButton(onPressed: () {
            showDialog(context: context, builder: (BuildContext context) =>
              AlertDialog(
                title: Text('Tem certeza que deseja excluir ${animal.nome} ?'),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('Não'),),
                  TextButton(onPressed: () {
                    Provider.of<AnimaisRepository>(context, listen: false).removeAnimal(animal);
                    Provider.of<UsuarioRepository>(context, listen: false).removeMeusAnimais(animal);
                    Provider.of<AdocoesRepository>(context, listen: false).deleteAdocaoByAnimal(animal);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Pet excluido com sucesso!'),
                          duration: const Duration(seconds: 1)));
                  }, child: const Text('Sim'),)
                ],
              )
            );
          }, icon: Icon(Icons.delete)),
        ]
        : 
        []
        ,
      ),
      body: InfoAnimal(animal),
      bottomSheet: 
        animal.dono.login != usuario.usuario.login   // Quem entrou na página não adicionou o animal
          ?
            !adocoes.inUserAdocoes(animal, usuario.usuario.login) // Usuario já esta em processo de adocao desse animal
            ?
            ElevatedButton(
              onPressed: () {
                    if(usuario.usuario.login == ''){
                      showDialog(context: context, builder: (BuildContext context) =>
                        AlertDialog(
                          title: const Text('Requer login'),
                          content: Text('Para adotar um animal você deve estar logado no sistema...'),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(context), 
                              child: const Text('Cancelar', style: TextStyle(color: Colors.redAccent),),),
                            TextButton(onPressed: () {
                              Navigator.pop(context);
                              Navigator.of(context).pushReplacementNamed(AppRoutes.LOGIN);
                            }, child: const Text('Fazer login'),)
                          ],
                        )
                      );
                    } else {
                      adocoes.addAdocao(animal, usuario.usuario).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Processo de adoção iniciado!'),
                          duration: const Duration(seconds: 1)));
                        
                        Navigator.of(context).pop();
                      });
                    } 
                    },
              child: SizedBox(
                height: 50,
                child: Center(
                  child: Text(
                    'Adotar',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            )
          :
            ElevatedButton(
              onPressed: () {
                      var adocao = Provider.of<AdocoesRepository>(context, listen: false).findByAnimal(animal);
                      Navigator.of(context).pushNamed(AppRoutes.ADOCAO_DETAIL, arguments: adocao[0]);
                    },
              child: SizedBox(
                height: 50,
                child: Center(
                  child: Text(
                    'Visualizar processo desta adoção',
                    style: TextStyle(fontSize: 19),
                  ),
                ),
              ),
            )
          
          // Quem entrou na página adicionou o animal
          :
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.ADOCAO_UNIQUE, arguments: animal);
            }, 
            child: SizedBox(
              height: 50,
              child: Center(
                child: Text('Interessados em adotar', style: TextStyle(fontSize: 20),),
              ),
            )
          ),
    );
  }
}
