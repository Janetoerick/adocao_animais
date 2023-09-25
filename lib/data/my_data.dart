import '../models/animal.dart';

List<Animal> animais = [
  Animal(
    id: 'l01',
    novo: true,
    tipo: 'Gato',
    nome: 'Felix o gato',
    sexo: 'Macho',
    porte: 'Pequeno',
    idade: '4 meses',
    img:
        'https://veterinariadavinci.com.br/blog/wp-content/uploads/2017/05/os-cuidados-com-filhotes-de-gatos.jpg',
    raca: 'falino',
    descricao: 'Branco com manchas pretas',
    contato: ['994412255'],
    data_registro: DateTime.now(),
  ),
  Animal(
    id: 'l02',
    novo: false,
    tipo: 'Cachorro',
    nome: 'Au o cão',
    sexo: 'Femea',
    porte: 'Medio',
    idade: '1 ano e 2 meses',
    img:
        'https://t1.ea.ltmcdn.com/pt/posts/4/2/8/pedigree_de_cachorro_o_que_e_e_como_fazer_1824_600.jpg',
    raca: 'Golden',
    descricao: 'Peludo',
    contato: ['994455525', 'creidi@gmail.com'],
    data_registro: DateTime.now(),
  ),
  Animal(
    id: 'l03',
    novo: false,
    tipo: 'Gato',
    nome: 'Antônio Gebedaia',
    sexo: 'Macho',
    porte: 'Pequeno',
    idade: '1 ano',
    img:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3g1PlXY0Ua0aWAq6yTdOyl2kRyf-VlGdvQw&usqp=CAU',
    raca: 'Viralata',
    descricao: 'Toma remedio controlado',
    contato: ['996487115', 'gilbertodoido@gmail.com'],
    data_registro: DateTime.now(),
  ),
];
