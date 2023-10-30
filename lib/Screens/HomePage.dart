import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prova/Screens/ClassProfileUser.dart';
import 'package:prova/Screens/ClassRecipes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController searchBar= TextEditingController();
  List<String> listOfTitleRecipes=[   //questa è la lista dei titoli delle ricette, bisogna inserire i titoli quì per far funzionare la "search bar"
    "carbonara",
    "matriciana",
    "tiramisù",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(   //in questa parte di codice ho messo lo sfondo dell'app con dei colori usando il "linear gradient"
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(255, 220, 132, 62),
            Color.fromRGBO(129, 255, 240, 17)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: ConvexAppBar(
          style: TabStyle.fixedCircle,
          items: const [
            TabItem(icon: Icons.home, title: 'Home'),
            //TabItem(icon: Icons.map, title: 'Discovery'),
            TabItem(icon: Icons.add, title: 'Add'),   //schermata per aggiungere una nuova ricetta da parte dell'utente
            //TabItem(icon: Icons.message, title: 'Message'),
            TabItem(icon: Icons.person, title: 'Profile'),
          ],
          onTap: (int screen){
            setState(() {
              if(screen == 0){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
              }
              if(screen == 2){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ClassProfileUser()));
              }
            });
          },
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(   //questa è una Row con il nome dell'app e l'immagine del profilo dell'utente
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("Random Eat", style: TextStyle(fontSize: 23),),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1),
                    ),
                    child: const Icon(Icons.person, size: 40,),   //al posto dell'icona, va messo l'immagine del profilo scelto dall'utente, si userà il pacake "shared_preference" per mantenere l'immagine del profilo fino alla nuova sostituzione di una nuova immagine
                  ),
                ],
              ),
            ),
            Padding(    //questa è la struttura della barra di ricerca
              padding: const EdgeInsets.only(top: 15, bottom: 10),
              child: Container(
                width: 250,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child:Autocomplete<String>(optionsBuilder:
                    (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return listOfTitleRecipes.where((String option) {
                    return option
                        .contains(textEditingValue.text.toLowerCase());
                  });
                }, fieldViewBuilder: (BuildContext context,
                    TextEditingController textEditingController,
                    FocusNode focusNode,
                    VoidCallback onFieldSubmitted) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: TextField(
                      controller: textEditingController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "Search",
                        border: InputBorder.none,
                      ),
                      focusNode: focusNode,
                    ),
                  );
                }, onSelected: (String selection) {
                  if (selection.toLowerCase() == "carbonara") {
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => const ClassSimpleCircularProgressBar()));
                  }
                  if (selection.toLowerCase() == "matriciana") {
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => const ClassSimpleCircularProgressBar()));
                  }
                  if (selection.toLowerCase() == "tiramisù") {
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => const ClassSimpleCircularProgressBar()));
                  }
                }
                ),
              ),
            ),
            const Text("Categories", style: TextStyle(fontSize: 23),),
            Padding(      //qui trovi alcune immagini con i relativi testi che fanno rifemento all loro categoria
              padding: const EdgeInsets.only(top: 5),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(width: 10,),
                    InkWell(
                      child: Column(
                        children: [
                          Image.asset("images/image_breakfast.png", height: 100,),
                          const Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text("Breakfast"),
                          ),
                        ],
                      ),
                      onTap: (){
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => const ClassSimpleCircularProgressBar()));
                      }
                    ),
                    const SizedBox(width: 10,),
                    InkWell(
                        child: Column(
                          children: [
                            Image.asset("images/image_lunch.png", height: 100,),
                            const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text("Lunch"),
                            ),
                          ],
                        ),
                        onTap: (){
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => const ClassSimpleCircularProgressBar()));
                        }
                    ),
                    const SizedBox(width: 10,),
                    InkWell(
                        child: Column(
                          children: [
                            Image.asset("images/image_dinner.png", height: 100,),
                            const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text("Dinner"),
                            ),
                          ],
                        ),
                        onTap: (){
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => const ClassSimpleCircularProgressBar()));
                        }
                    ),
                    const SizedBox(width: 10,),
                    InkWell(
                        child: Column(
                          children: [
                            Image.asset("images/image_dessert.png", height: 100,),
                            const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text("Dessert"),
                            ),
                          ],
                        ),
                        onTap: (){
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => const ClassSimpleCircularProgressBar()));
                        }
                    ),
                    const SizedBox(width: 10,),
                    InkWell(
                        child: Column(
                          children: [
                            Image.asset("images/image_pizza.png", height: 100,),
                            const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text("Pizza"),
                            ),
                          ],
                        ),
                        onTap: (){
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => const ClassSimpleCircularProgressBar()));
                        }
                    ),
                    const SizedBox(width: 10,),
                  ],
                ),
              ),
            ),
            Container(      //questo codice fa riferimento al contenitore in cui verrà visualizzato l'immagine, il titolo e una breve descrizione della ricetta
              width: double.infinity,
              height: 241.4,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(119, 255, 132, 53),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              ),
              child: Column(      //qui vedrai messi in colonna le varie informazioni della ricetta
                children: [
                  Image.asset("images/image_dinner.png", width: 120, height: 100,),     //qui verrà messa l'immagine inerente alla relativa ricetta
                  const Text("Title", style: TextStyle(fontSize: 21),),
                  const Text("..."),

                  Padding(
                    padding: const EdgeInsets.only(top: 35, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: (){

                          },
                          child: const Text("Random Recipes"),
                        ),
                        ElevatedButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ClassRecipes()));
                          },
                          child: const Text("Read More"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
