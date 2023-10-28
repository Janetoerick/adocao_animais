import 'package:adocao_animais/models/animal.dart';
import 'package:adocao_animais/models/usuario.dart';
import 'package:adocao_animais/repositories/animais_repository.dart';
import 'package:adocao_animais/repositories/usuario_repository.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class FormAnimalScreen extends StatefulWidget {
  const FormAnimalScreen({super.key});

  @override
  State<FormAnimalScreen> createState() => _FormAnimalScreenState();
}

class _FormAnimalScreenState extends State<FormAnimalScreen> {
  final _racaFocus = FocusNode();
  final _idadeFocus = FocusNode();

  final _imageUrlController = TextEditingController();
  List<String> _imagens = [];

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  final List<String> _portes = <String>['Pequeno', 'Médio', 'Grande'];
  final List<String> _sexos = <String>['Macho', 'Fêmea'];
  final List<String> _especies = <String>['Cachorro', 'Gato', 'Coelho', 'Papagaio'];

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');
    return isValidUrl && endsWithFile;
  }

  @override
  void initState(){
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final animal = arg as Animal;
        _formData['id'] = animal.id;
        _formData['dono'] = animal.dono;
        _formData['novo'] = animal.novo;
       _formData['especie'] = animal.especie;
       _formData['nome'] = animal.nome;
       _formData['porte'] = animal.porte;
       _formData['sexo'] = animal.sexo;
       _formData['idade'] = animal.idade;
       _formData['img'] = animal.img;
       _formData['raca'] = animal.raca;
       _formData['descricao'] = animal.descricao;
       _formData['data_registro'] = animal.data_registro;
       _formData['favorito'] = animal.isFavorito;

        setState(() {
          _imagens.addAll(animal.img);
        });
      }
    }
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();
    var user = Provider.of<UsuarioRepository>(context, listen: false).usuario;

    _formData['img'] = _imagens;
    
    Provider.of<AnimaisRepository>(
      context,
      listen: false,
    ).saveAnimal(_formData, user).then((value) {
      Provider.of<UsuarioRepository>(context, listen: false).setUpMeusAnimais();
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forms Pet')),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(                                                                     // NOME
                initialValue: _formData['nome']?.toString(),
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
                focusNode: _racaFocus,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_idadeFocus);
                },
                onSaved: (nome) => _formData['nome'] = nome ?? '',
                validator: (nome) {
                  if(nome == null || nome == ''){
                    return 'Campo obrigatório';
                  }
                },
              ),
              TextFormField(                                                                     // RAÇA
                initialValue: _formData['raca']?.toString(),
                decoration: InputDecoration(
                  labelText: 'Raça',
                ),
                textInputAction: TextInputAction.next,
                focusNode: _idadeFocus,
                onSaved: (raca) => _formData['raca'] = raca ?? '',
                validator: (raca) {
                  if(raca == null || raca == ''){
                    return 'Campo obrigatório';
                  }
                },
              ),
              TextFormField(                                                                     // IDADE
                initialValue: _formData['idade']?.toString(),
                decoration: InputDecoration(
                  labelText: 'Idade (Ex.: 2 anos e 1 mes)',
                ),
                textInputAction: TextInputAction.next,
                onSaved: (idade) => _formData['idade'] = idade ?? '',
                validator: (idade) {
                  if(idade == null || idade == ''){
                    return 'Campo obrigatório';
                  }
                },
              ),

              DropdownButton(                                                                     // ESPECIE
              hint: Text('Espécie'),
              padding: EdgeInsets.only(top: 20),
                isExpanded: true,
                value: _formData['especie']?.toString(),
                onChanged: (String? value){
                  setState(() {
                    _formData['especie'] = value!;
                  });
                },
                items: _especies.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                ),
              TextFormField(                                                                     // DESCRICAO
                initialValue: _formData['descricao']?.toString(),
                decoration: InputDecoration(
                  labelText: 'Descrição',
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_idadeFocus);
                },
                onSaved: (descricao) => _formData['descricao'] = descricao ?? '',
                validator: (descricao) {
                  if(descricao == null || descricao == ''){
                    return 'Campo obrigatório';
                  }
                },
              ),
              Container(                                                                          // SEXO
                height: 100,
                padding: EdgeInsets.only(top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sexo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    Container(
                      height: 60,
                      padding: EdgeInsets.only(top: 10),
                      child: GridView.builder(
                        itemCount: _sexos.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        mainAxisExtent: 50,
                      ), 
                      itemBuilder: (_, int index) {
                        return Card(
                          child: ElevatedButton(
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(
                              _formData['sexo'] == _sexos[index] 
                            ? Theme.of(context).colorScheme.secondary
                            : Colors.white
                            )),
                            onPressed: () {
                              setState(() {
                                _formData['sexo'] = _sexos[index];  
                              });
                            },
                            child: Center(
                              child: Text(
                                _sexos[index],
                                style: TextStyle(
                                  color: _formData['sexo'] == _sexos[index] 
                                      ? Colors.white 
                                      : Colors.black 
                                ),
                              )
                            ),
                          ),
                        );
                      }),
                    )  
                  ],
                ),
              ),
              Container(                                                                          // PORTE
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Porte', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    Container(
                      height: 60,
                      padding: EdgeInsets.only(top: 10),
                      child: GridView.builder(
                        itemCount: _portes.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        mainAxisExtent: 50,
                      ), 
                      itemBuilder: (_, int index) {
                        return Card(
                          child: ElevatedButton(
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(
                              _formData['porte'] == _portes[index] 
                            ? Theme.of(context).colorScheme.secondary
                            : Colors.white
                            )),
                            onPressed: () {
                              setState(() {
                                _formData['porte'] = _portes[index];  
                              });
                            },
                            child: Center(
                              child: Text(
                                _portes[index],
                                style: TextStyle(
                                  color: _formData['porte'] == _portes[index] 
                                      ? Colors.white 
                                      : Colors.black 
                                ),
                              )
                            ),
                          ),
                        );
                      }),
                    )  
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                            decoration: InputDecoration(labelText: 'Url da Imagem'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            onFieldSubmitted: (_) {
                              
                            },
                            onSaved: (imageUrl) =>
                            _formData['imageUrl'] = imageUrl ?? '',
                            validator: (_imageUrl) {
                              if (_imagens.isEmpty) {
                                return 'Registre pelo menos uma imagem!';
                              }
                            
                              return null;
                            },
                        ),
                      ),
                      IconButton(onPressed: () {
                        if(isValidImageUrl(_imageUrlController.text)){
                                setState(() {
                                  _imagens.add(_imageUrlController.text);
                                  _imageUrlController.clear();  
                                });
                              }
                      }, icon: Icon(Icons.add))
                    ],
                  ),
                  
                  Container(
                    height: 100,
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 10),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _imagens.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Container(
                            height: 100,
                            width: 100,
                            child: Stack(children: [
                              Image.network(_imagens[index], width: 100, height: 100, fit: BoxFit.fill,),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _imagens.remove(_imagens[index]);  
                                    });
                                  }, 
                                  icon: Icon(Icons.remove_circle)
                                )
                              )
                            ])),
                          );
                      })
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            _submitForm();
            final snackBarConfrim = SnackBar(
              content: const Text(
                  'Salvo com sucesso!'),
                  duration: Duration(milliseconds: 900),
            );
            ScaffoldMessenger.of(context)
                .showSnackBar(snackBarConfrim);
          }, 
          child: Text('Salvar', style: TextStyle(fontSize: 20),),
          )
        ),
    );
  }
}