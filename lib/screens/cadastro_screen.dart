import 'dart:math';

import 'package:adocao_animais/models/usuario.dart';
import 'package:adocao_animais/repositories/usuario_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:provider/provider.dart';

class CadastroScreen extends StatefulWidget {
  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();

    var _nome = TextEditingController();
    var _email = TextEditingController();
    var _telefone = TextEditingController();
    var _cpf = TextEditingController();
    var _login = TextEditingController();
    var _senha = TextEditingController();
    var _senhaConfirm = TextEditingController();

    String error_login = '';

    void _submitForm() {
    error_login = '';
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    Provider.of<UsuarioRepository>(
      context, 
      listen: false,
    ).cadastrarUsuario(
      new Usuario(
        nome: _nome.text,
        email: _email.text, 
        telefone: _telefone.text, 
        cpf: _cpf.text, 
        login: _login.text, 
        senha: _senha.text))
     .then((value) {
      if(value){
        Navigator.of(context).pop();
      } else {
        setState(() {
          error_login = 'Este login já está em uso';  
        });
      }
     });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Login'),
                    controller: _login,
                    validator: (value) {
                          if (value == null || value == '') {
                            return 'Campo obrigatório';
                          }
                        },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Nome'),
                    controller: _nome,
                    validator: (value) {
                          if (value == null || value == '') {
                            return 'Campo obrigatório';
                          }
                        },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email'),
                    controller: _email,
                    validator: (value) {
                          if (value == null || value == '') {
                            return 'Campo obrigatório';
                          } else if (!value.contains('@') || !value.contains('.')){
                            return 'Email inválido';
                          }
                        },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Telefone'),
                    controller: _telefone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter(),
                    ],
                    validator: (value) {
                          if (value == null || value == '') {
                            return 'Campo obrigatório';
                          }
                        },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'CPF'),
                    controller: _cpf,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter(),
                    ],
                    validator: (value) {
                          if (value == null || value == '') {
                            return 'Campo obrigatório';
                          }
                        },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Senha'),
                    controller: _senha,
                    obscureText: true,
                    validator: (value) {
                          if (value == null || value == '') {
                            return 'Campo obrigatório';
                          } else if(value != _senhaConfirm.text){
                            return 'Senhas diferentes';
                          }
                        },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Confirmar senha'),
                    controller: _senhaConfirm,
                    obscureText: true,
                    validator: (value) {
                          if (value == null || value == '') {
                            return 'Campo obrigatório';
                          } else if (value != _senha.text){
                            return 'Senhas diferentes';
                          }
                        },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        _submitForm();
                      },
                      child: Text('Cadastrar',
                      style: TextStyle(fontSize: 20,),),
                    ),
                  ),
                  Container(
                    height: 30,
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      error_login, style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
