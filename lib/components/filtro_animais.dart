import 'package:flutter/material.dart';

class FiltroAnimais extends StatefulWidget {
  final String filterSave;
  Function(String) onSubmit;
  FiltroAnimais(this.filterSave, this.onSubmit);

  _FiltroAnimais createState() => _FiltroAnimais();
}

class _FiltroAnimais extends State<FiltroAnimais> {
  List<String> list_name = <String>['Cachorro', 'Gato', 'Coelho', 'Papagaio'];
  List<String> list_img = <String>['lib/assets/icon_cachorro.png', 'lib/assets/icon_gato.png', 'lib/assets/icon_coelho.png', 'lib/assets/icon_papagaio.png'];

  String? typeSelect;
  
  @override
  initState(){
    setState(() {
      if(widget.filterSave.toString() != ''){
        typeSelect = widget.filterSave.toString();
      }  
    });
    
  }

  @override
  Widget build(BuildContext context) {
    

    return Container(
      height: 300,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 80,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: list_name.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        typeSelect = list_name[index];  
                      });
                    },
                    child: Container(
                      width: 150,
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            right: 20,
                            left: 0,
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                color: 
                                typeSelect == list_name[index] ?
                                  Color.fromARGB(255, 219, 219, 219)
                                :
                                  Color.fromARGB(255, 241, 241, 241)
                                ,
                                borderRadius: BorderRadius.circular(15)
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 1,
                            child: Container(
                              height: 60, 
                                width: 100,
                              child: Image.asset(
                                list_img[index], 
                                width: 50,
                                height: 50,
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.fitHeight,
                                color: 
                                typeSelect == list_name[index] 
                                ? Theme.of(context).colorScheme.secondary
                                : Colors.black45
                                ,
                                ),
                            )
                          ),
                          Positioned(
                            bottom: 10,
                            right: 30,
                            child: Text(
                              list_name[index],
                              style: TextStyle(
                                fontWeight: 
                                  typeSelect == list_name[index] 
                                  ? FontWeight.bold 
                                  : FontWeight.normal,
                                color: 
                                  typeSelect == list_name[index] 
                                  ? Theme.of(context).colorScheme.secondary
                                  : Colors.black45
                                ),
                            ),),
                        ],
                                      ),
                    ),
                  );
                },
                ),
            ),
            SizedBox(
              width: double.infinity - 20,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 150,
                    child: SizedBox.expand(
                      child: ElevatedButton(
                        onPressed: () {
                          widget.onSubmit(typeSelect!);
                          Navigator.of(context).pop();
                          // if (dropdownValue != '') {
                          //   widget.onSubmit(dropdownValue!);
                          // }
                        },
                        child: Text(
                          "Filtrar",
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).colorScheme.secondary),
                            ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                   Container(
                    height: 50,
                    width: 150,
                    child: SizedBox.expand(
                      child: ElevatedButton(
                        onPressed: () {
                          widget.onSubmit('');
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Limpar Filtro",
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 219, 219, 219)),
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
