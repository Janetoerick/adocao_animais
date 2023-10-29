import 'package:adocao_animais/components/lista_adocoes.dart';
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
  @override
  Widget build(BuildContext context) {
    final animal = ModalRoute.of(context)?.settings.arguments as Animal;

    final user = Provider.of<UsuarioRepository>(context, listen: false).usuario;
    final adocao = Provider.of<AdocoesRepository>(context, listen: false).findByAnimal(animal);

    final bool isDono = adocao.animal.dono.login == user.login;

    final List<String> options = ['em processo...', 'rejeitado', 'aprovado'];
    String dropdownValue = adocao.status;

    return Scaffold(
      appBar: AppBar(
        title: Text('Processo de adoção'),
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
                          Icons.smartphone, 
                          color: Theme.of(context).colorScheme.secondary,
                          size: 30,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Container(
                          child: Text(
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
                            adocao.animal.dono.email, 
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary, 
                              fontSize: 24,
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
                      dropdownValue == adocao.status ? 
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
                        DropdownButton<String>(
                              value: adocao.status,
                              elevation: 16,
                              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                              underline: Container(
                                height: 2,
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownValue = value!;
                                });
                              },
                              items: options.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
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
                dropdownValue != adocao.status ?
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                  ),
                  
                  width: 300,
                  height: 40,
                  child:
                  ElevatedButton(
                    onPressed: () {}, 
                    child: Text('Salvar')
                  )
                )
                :
                Container(
                  height: 40,
                  child: Container()
                )
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}