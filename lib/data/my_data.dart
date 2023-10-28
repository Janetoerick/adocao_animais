import 'package:adocao_animais/models/usuario.dart';

import '../models/animal.dart';
import 'package:intl/intl.dart';

final URLrepository = 'https://adocao-animais-default-rtdb.firebaseio.com/';

final data = DateTime.now();

final List<Animal> animaisData = [
  Animal(
    id: 'l01',
    dono: Usuario(nome: 'Janeto Erick', email: 'janeto@teste.com', telefone: '(84) 92927-7488', cpf: '938.387.483-92', login: 'janeto', senha: '123'),
    novo: true,
    especie: 'Gato',
    nome: 'Felix o gato',
    sexo: 'Macho',
    porte: 'Pequeno',
    idade: '4 meses',
    img:
        ['https://veterinariadavinci.com.br/blog/wp-content/uploads/2017/05/os-cuidados-com-filhotes-de-gatos.jpg'],
    raca: 'falino',
    descricao: 'Branco com manchas pretas',
    data_registro: DateFormat('dd-MM-yyyy').format(data),
    isFavorito: [],
  ),
  Animal(
    id: 'l02',
    dono: Usuario(nome: 'Janeto Erick', email: 'janeto@teste.com', telefone: '(84) 92927-7488', cpf: '938.387.483-92', login: 'janeto', senha: '123'),
    novo: false,
    especie: 'Cachorro',
    nome: 'Au o cão',
    sexo: 'Femea',
    porte: 'Medio',
    idade: '1 ano e 2 meses',
    img:
        ['https://t1.ea.ltmcdn.com/pt/posts/4/2/8/pedigree_de_cachorro_o_que_e_e_como_fazer_1824_600.jpg'],
    raca: 'Golden',
    descricao: 'Peludo',
    data_registro: DateFormat('dd-MM-yyyy').format(data),
    isFavorito: [],
  ),
  Animal(
    id: 'l03',
    dono: Usuario(nome: 'Janeto Erick', email: 'janeto@teste.com', telefone: '(84) 92927-7488', cpf: '938.387.483-92', login: 'janeto', senha: '123'),
    novo: false,
    especie: 'Gato',
    nome: 'Antônio Gebedaia',
    sexo: 'Macho',
    porte: 'Pequeno',
    idade: '1 ano',
    img:
        ['https://www.petz.com.br/blog/wp-content/uploads/2023/01/gato-com-felv-pode-tomar-vacina-3.jpg'],
    raca: 'Viralata',
    descricao: 'Toma remedio controlado',
    data_registro: DateFormat('dd-MM-yyyy').format(data),
    isFavorito: [],
  ),
  Animal(
    id: 'l04',
    dono: Usuario(nome: 'Janeto Erick', email: 'janeto@teste.com', telefone: '(84) 92927-7488', cpf: '938.387.483-92', login: 'janeto', senha: '123'),
    novo: true,
    especie: 'Cachorro',
    nome: 'Valentino',
    sexo: 'Femea',
    porte: 'Pequeno',
    idade: '2 ano e 1 mês',
    img:
        ['https://conteudo.imguol.com.br/c/entretenimento/54/2020/04/28/cachorro-pug-1588098472110_v2_1x1.jpg'],
    raca: 'Pug',
    descricao: 'Sabe usar a caixa de areia',
    data_registro: DateFormat('dd-MM-yyyy').format(data),
    isFavorito: [],
  ),
  Animal(
    id: 'l05',
    dono: Usuario(nome: 'Janeto Erick', email: 'janeto@teste.com', telefone: '(84) 92927-7488', cpf: '938.387.483-92', login: 'janeto', senha: '123'),
    novo: false,
    especie: 'Cachorro',
    nome: 'Crodoaldo Romero',
    sexo: 'Macho',
    porte: 'Grande',
    idade: '1 ano e 10 mês',
    img:
        ['https://petcare.com.br/wp-content/uploads/2023/03/personalidade-cachorro-caramelo.jpg'],
    raca: 'Viralata',
    descricao: 'Gosta de brincar de pegar',
    data_registro: DateFormat('dd-MM-yyyy').format(data),
    isFavorito: [],
  ),
  Animal(
    id: 'l06',
    dono: Usuario(nome: 'Janeto Erick', email: 'janeto@teste.com', telefone: '(84) 92927-7488', cpf: '938.387.483-92', login: 'janeto', senha: '123'),
    novo: false,
    especie: 'Cachorro',
    nome: 'Raimundim',
    sexo: 'Macho',
    porte: 'Pequeno',
    idade: '4 meses',
    img:
        ['https://t2.uc.ltmcdn.com/pt/posts/6/0/4/como_cuidar_de_um_dachshund_19406_orig.jpg'],
    raca: 'Salsicha',
    descricao: 'Muito amigável e brincaçhão',
    data_registro: DateFormat('dd-MM-yyyy').format(data),
    isFavorito: [],
  ),
  Animal(
    id: 'l07',
    dono: Usuario(nome: 'Janeto Erick', email: 'janeto@teste.com', telefone: '(84) 92927-7488', cpf: '938.387.483-92', login: 'janeto', senha: '123'), //'janeto', 
    novo: false,
    especie: 'Cachorro',
    nome: 'Pamonha',
    sexo: 'Femea',
    porte: 'Médio',
    idade: '10 meses',
    img:
        ['https://www.fatosdesconhecidos.com.br/wp-content/uploads/2021/12/caramelo-03-647x450.jpg'],
    raca: 'Viralata',
    descricao: 'Gosta de passear',
    data_registro: DateFormat('dd-MM-yyyy').format(data),
    isFavorito: [],
  ),
];
