import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ClassProfileUser.dart';
import 'HomePage.dart';

class ClassRecipes extends StatefulWidget {
  const ClassRecipes({Key? key}) : super(key: key);

  @override
  State<ClassRecipes> createState() => _ClassRecipesState();
}

class _ClassRecipesState extends State<ClassRecipes> {

  PageController pageController= PageController();

  List<Container> listOfContainer = [
    Container(
      child: Stack(
        children: [
          Stepper(
            type:  StepperType.horizontal,
            steps: [
              Step(
                title: const Text("Title"),
                content: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      width: double.infinity,
                      height: 250,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors
                            .green, //questo colore è solo per dimostrare, poi verrà cambiato
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: const [
                            Text("Title", style: TextStyle(fontSize: 26)),
                            Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                                  "Proin varius nulla non orci hendrerit ullamcorper. Donec "
                                  "turpis nibh, maximus et neque convallis, accumsan aliquam "
                                  "ex. Nunc eget pellentesque risus. Nam scelerisque nisi sed "
                                  "mauris vestibulum consequat. Donec massa augue, bibendum "
                                  "sit amet ipsum eu, euismod gravida erat.",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Step(
                title: const Text("Title"),
                content: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      width: double.infinity,
                      height: 250,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors
                            .green, //questo colore è solo per dimostrare, poi verrà cambiato
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: const [
                            Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                                  "Proin varius nulla non orci hendrerit ullamcorper. Donec "
                                  "turpis nibh, maximus et neque convallis, accumsan aliquam "
                                  "ex. Nunc eget pellentesque risus. Nam scelerisque nisi sed "
                                  "mauris vestibulum consequat. Donec massa augue, bibendum "
                                  "sit amet ipsum eu, euismod gravida erat.",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Step(
                title: const Text("Title"),
                content: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      width: double.infinity,
                      height: 250,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors
                            .green, //questo colore è solo per dimostrare, poi verrà cambiato
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: const [
                            Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                                  "Proin varius nulla non orci hendrerit ullamcorper. Donec "
                                  "turpis nibh, maximus et neque convallis, accumsan aliquam "
                                  "ex. Nunc eget pellentesque risus. Nam scelerisque nisi sed "
                                  "mauris vestibulum consequat. Donec massa augue, bibendum "
                                  "sit amet ipsum eu, euismod gravida erat.",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
        //la barra di navigazione posizionata in basso alla schermata
        style: TabStyle.fixedCircle,
        backgroundColor: const Color.fromRGBO(42, 41, 41, 1),
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          //TabItem(icon: Icons.map, title: 'Discovery'),
          TabItem(icon: Icons.add, title: 'Add'),
          //schermata per aggiungere una nuova ricetta da parte dell'utente
          //TabItem(icon: Icons.message, title: 'Message'),
          TabItem(icon: Icons.person, title: 'Profile'),
        ],
        onTap: (int screen) {
          setState(() {
            if (screen == 0) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            }
            if (screen == 2) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ClassProfileUser()));
            }
          });
        },
      ),
      body: Stack(
        children: [
          Image.asset("images/image_backgound_screen_deatils_repicies.png"),
          PageView(
            controller: pageController,
            children: listOfContainer,
          ),
        ],
      ),
    );
  }
}
