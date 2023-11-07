import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prova/Screens/ClassProfileUser.dart';
import 'package:prova/Screens/ClassRecipes.dart';
import 'package:prova/Screens/ClassSearchScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ClassProfileUser classProfileUser= ClassProfileUser();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onBackButtonPressed(context),
      child: Scaffold(
        backgroundColor: classProfileUser.backgroundScaffold ?? const Color.fromRGBO(19, 17, 17, 1), //questo è il colore di base dell'app (const Color.fromRGBO(19, 17, 17, 1),)
        appBar: AppBar(
          title: const Text("Random Eat", style: TextStyle(fontSize: 23, color: Colors.white),),
          backgroundColor: const Color.fromRGBO(42, 41, 41, 1),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ClassSearchScreen()));
              },
            ),
          ],
        ),
        bottomNavigationBar: ConvexAppBar(
          style: TabStyle.fixedCircle,
          backgroundColor: const Color.fromRGBO(42, 41, 41, 1),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => ClassProfileUser()));
              }
            });
          },
        ),
        body: Stack(
          children: [
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Categories", style: TextStyle(fontSize: 23),),
                ),
                SingleChildScrollView(
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
                                child: Text("Breakfast", style: TextStyle(color: Colors.white)),
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
                                child: Text("Lunch", style: TextStyle(color: Colors.white)),
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
                                child: Text("Dinner", style: TextStyle(color: Colors.white)),
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
                                child: Text("Dessert", style: TextStyle(color: Colors.white)),
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
                                child: Text("Pizza", style: TextStyle(color: Colors.white)),
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
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Pianificazione per oggi", style: TextStyle(fontSize: 23, color: Colors.white),),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(      //questo codice fa riferimento al contenitore in cui verrà visualizzato l'immagine, il titolo e una breve descrizione della ricetta
                width: double.infinity,
                height: 350,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(248, 184, 78, 1),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                ),
                child: Column(      //qui vedrai messi in colonna le varie informazioni della ricetta
                  children: [
                    Image.asset("images/image_dinner.png", width: 120, height: 100,),     //qui verrà messa l'immagine inerente alla relativa ricetta
                    const Text("Title", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const Text("description...", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                    Padding(
                      padding: const EdgeInsets.only(top: 115, left: 10, right: 10),
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
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> onBackButtonPressed(BuildContext context) async{
    bool? exitApp= await showDialog(
        context: context,
        builder: (BuildContext contex){
          return AlertDialog(
            title: const Text("Exit App"),
            content: const Text("Do you want to close the app?"),
            actions: [
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pop(false);
                },
                child: const Text("No"),
              ),
              ElevatedButton(
                onPressed: (){
                  SystemNavigator.pop();
                },
                child: const Text("Yes"),
              ),
            ],
          );
        }
    );
    return exitApp ?? false;
  }
}
