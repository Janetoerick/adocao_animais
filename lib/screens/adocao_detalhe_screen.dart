import 'package:adocao_animais/components/lista_adocoes_all.dart';
import 'package:adocao_animais/models/adocao.dart';
import 'package:adocao_animais/models/animal.dart';
import 'package:adocao_animais/repositories/adocoes_repository.dart';
import 'package:adocao_animais/repositories/usuario_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdocaoDetalheScreen extends StatefulWidget {
  const AdocaoDetalheScreen({super.key});

  @override
  State<AdocaoDetalheScreen> createState() => _AdocaoScreenState();
}

class _AdocaoScreenState extends State<AdocaoDetalheScreen> {
  String dropdownValue = '';

  @override
  Widget build(BuildContext context) {
    final adocao = ModalRoute.of(context)?.settings.arguments as Adocao;

    final user = Provider.of<UsuarioRepository>(context, listen: false).usuario;

    final bool isDono = adocao.animal.dono.login == user.login;

    const List<String> options = <String>['em processo...', 'rejeitado', 'aprovado'];
    
    if(dropdownValue == ''){
      dropdownValue = adocao.status;
    }

    onSubmit(Adocao adocao, String status){
      final new_adocao = Adocao(id: adocao.id, usuario: adocao.usuario, animal: adocao.animal, status: status, data: adocao.data);

      Provider.of<AdocoesRepository>(context, listen: false).attAdocoes(new_adocao, true);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Processo de adoção'),
        actions: [
          !isDono  && adocao.status != 'aprovado' ?
          IconButton(
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
                      Navigator.of(context).pop();
                      Provider.of<AdocoesRepository>(context, listen: false).deleteAdocao(adocao);
                      Navigator.of(context).pop();
                    },
                    child: Text('Sim'),
                  ),
                ],
              ),
            )
          , icon: Icon(Icons.delete))
          :
          Container()
        ],
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                  width: 300,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Theme.of(context).colorScheme.secondary),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.person, 
                          color: Theme.of(context).colorScheme.secondary,
                          size: 30,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Container(
                          child: Text(
                            isDono 
                            ?
                            adocao.usuario.nome
                            :
                            adocao.animal.dono.nome
                            , 
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary, 
                              fontSize: 24,
                              fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 300,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Theme.of(context).colorScheme.secondary),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.smartphone, 
                          color: Theme.of(context).colorScheme.secondary,
                          size: 30,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Container(
                          child: Text(
                            isDono 
                            ?
                            adocao.usuario.telefone
                            :
                            adocao.animal.dono.telefone, 
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary, 
                              fontSize: 24,
                              fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 300,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Theme.of(context).colorScheme.secondary),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.mail, 
                          color: Theme.of(context).colorScheme.secondary,
                          size: 30,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Container(
                          child: Text(
                            isDono 
                            ?
                            adocao.usuario.email
                            :
                            adocao.animal.dono.email
                            , 
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary, 
                              fontSize: 24
                              ,
                              fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 300,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Theme.of(context).colorScheme.secondary),
                    borderRadius: 
                      !isDono ?
                        BorderRadius.circular(20) 
                      : 
                        BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Status:', 
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary, 
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      isDono ?
                        DropdownMenu<String>(
                              initialSelection: dropdownValue,
                              onSelected: (String? value) {
                                setState(() {
                                  dropdownValue = value!;
                                });
                              },
                              dropdownMenuEntries: options.map<DropdownMenuEntry<String>>((String value) {
                                return DropdownMenuEntry<String>(
                                  value: value,
                                  label: value,
                                );
                              }).toList(),
                            )
                      :
                      Text(
                        adocao.status, 
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary, 
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                        ),
                    ],
                  ),
                ),
                isDono
                ?
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                  ),
                  
                  width: 300,
                  height: 40,
                  child:
                  ElevatedButton(
                    onPressed: () {
                      Adocao new_adocao = Adocao(id: adocao.id, usuario: adocao.usuario, animal: adocao.animal, status: dropdownValue, data: adocao.data);
                      Provider.of<AdocoesRepository>(context, listen: false).attAdocoes(new_adocao, true).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Atualizado com sucesso!'),
                          duration: const Duration(seconds: 1)));
                        
                        Navigator.of(context).pop();
                      });
                    }, 
                    child: Text('Salvar')
                  )
                )
                : Container(height: 40,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}