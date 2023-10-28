import 'package:adocao_animais/main.dart';
import 'package:adocao_animais/repositories/usuario_repository.dart';
import 'package:adocao_animais/screens/home_screen.dart';
import 'package:adocao_animais/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:adocao_animais/screens/cadastro_screen.dart';
import 'package:adocao_animais/models/usuario.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  var _loginController = TextEditingController();
  var _senhaController = TextEditingController();

  String error_login = '';

  _onSubmitLogin(){
    error_login = '';
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    Provider.of<UsuarioRepository>(
      context,
      listen: false
    ).loginUsuario(_loginController.text, _senhaController.text)
    .then((value) {
      print(value.toString());
      if(value.toString() != 'OK'){
        setState(() {
          error_login = value.toString();  
        });
      } else {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset('lib/assets/coracao_patas.png', width: 200, height: 200, color: Theme.of(context).colorScheme.secondary,),
                  TextFormField(
                    controller: _loginController, // Captura o valor do campo de login
                    decoration: InputDecoration(labelText: 'Login'),
                    validator: (value) {
                      if(value == null || value == ''){
                        return 'Campo obrigatório!';
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _senhaController, // Captura o valor do campo de senha
                    decoration: InputDecoration(labelText: 'Senha'),
                    obscureText: true,
                    validator: (value) {
                      if(value == null || value == ''){
                        return 'Campo obrigatório!';
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
                        _onSubmitLogin();
                      },
                      child: Text('Entrar', style: TextStyle(fontSize: 20),),
                    ),
                  ),
                  Container(
                    height: 30,
                    alignment: Alignment.center,
                    child: Text(error_login, style: TextStyle(color: Colors.red),),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.CADASTRO_USER
                      );
                    },
                    child: Text('Criar uma conta'),
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
