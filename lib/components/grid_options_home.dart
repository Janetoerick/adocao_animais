import 'package:adocao_animais/repositories/usuario_repository.dart';
import 'package:adocao_animais/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GridOptionsHome extends StatelessWidget {
  const GridOptionsHome();

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UsuarioRepository>();

    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      crossAxisCount: 2,
      childAspectRatio: (1 / .7),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      cacheExtent: 50,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: SizedBox.expand(
            child: ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
              onPressed: () {
                if(user.usuario.login != ''){
                  Navigator.of(context).pushNamed(AppRoutes.FORM_ANIMAL);
                } else {
                  showDialog(context: context, builder: (BuildContext context) =>
                  AlertDialog(
                    
                    title: const Text('Requer login'),
                    content: const Text('Para cadastrar um pet você deve estar logado no sistema...'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar'),),
                      TextButton(onPressed: () {
                        Navigator.pop(context);
                        Navigator.of(context).pushNamed(AppRoutes.LOGIN);
                      }, child: const Text('Fazer login'),)
                    ],
                  ));
                }
                
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('lib/assets/pet_add.png', width: 50, height: 50, color: Theme.of(context).colorScheme.secondary,),
                  Text('Cadastrar pet para adoção', 
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold), 
                  textAlign: TextAlign.center,),
                ],
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: SizedBox.expand(
            child: ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
              onPressed: () {
                if(user.usuario.login != ''){
                  Navigator.of(context).pushNamed(AppRoutes.MEUS_PETS);
                } else {
                  showDialog(context: context, builder: (BuildContext context) =>
                  AlertDialog(
                    
                    title: const Text('Requer login'),
                    content: const Text('Para ver seus pets você deve estar logado no sistema...'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar'),),
                      TextButton(onPressed: () {
                        Navigator.pop(context);
                        Navigator.of(context).pushNamed(AppRoutes.LOGIN);
                      }, child: const Text('Fazer login'),)
                    ],
                  ));
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.pets, color: Theme.of(context).colorScheme.secondary, size: 55,),
                  Text('Meus pets', 
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold), 
                  textAlign: TextAlign.center,),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}