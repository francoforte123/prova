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
  PageController pageController = PageController();

  int _currentPage = 0;
  int numberPages = 0;

  List<Container> listOfScreen = [    //questa è la lista dei vari contenitori in cui verranno messi le varie informazioni relative alle varie ricette
    Container(
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                width: double.infinity,
                height: 250,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green,    //questo colore è solo per dimostrare, poi verrà cambiato
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: const [
                      Text("Title", style: TextStyle(fontSize: 26)),
                      Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                          "Proin varius nulla non orci hendrerit ullamcorper. Donec "
                          "turpis nibh, maximus et neque convallis, accumsan aliquam "
                          "ex. Nunc eget pellentesque risus. Nam scelerisque nisi sed "
                          "mauris vestibulum consequat. Donec massa augue, bibendum "
                          "sit amet ipsum eu, euismod gravida erat.", style: TextStyle(fontSize: 15),),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 42),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text("${1}/${3.toString()}", style: const TextStyle(color: Colors.white),),
            ),
          ),
        ],
      ),
    ),
    Container(
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                width: double.infinity,
                height: 250,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green,    //questo colore è solo per dimostrare, poi verrà cambiato
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                      "Proin varius nulla non orci hendrerit ullamcorper. Donec "
                      "turpis nibh, maximus et neque convallis, accumsan aliquam "
                      "ex. Nunc eget pellentesque risus. Nam scelerisque nisi sed "
                      "mauris vestibulum consequat. Donec massa augue, bibendum "
                      "sit amet ipsum eu, euismod gravida erat.", style: TextStyle(fontSize: 15),),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 42),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text("${2}/${3.toString()}", style: const TextStyle(color: Colors.white),),
            ),
          ),
        ],
      ),
    ),
    Container(
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                width: double.infinity,
                height: 250,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green,    //questo colore è solo per dimostrare, poi verrà cambiato
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                      "Proin varius nulla non orci hendrerit ullamcorper. Donec "
                      "turpis nibh, maximus et neque convallis, accumsan aliquam "
                      "ex. Nunc eget pellentesque risus. Nam scelerisque nisi sed "
                      "mauris vestibulum consequat. Donec massa augue, bibendum "
                      "sit amet ipsum eu, euismod gravida erat.", style: TextStyle(fontSize: 15),),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 42),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text("${3}/${3.toString()}", style: const TextStyle(color: Colors.white),),
            ),
          ),
        ],
      ),
    ),
  ];

  //queste sono le funzioni per permettere di andare avanti o indietro tra le varie pagine della ricetta
  void _nextPage() {
    if (_currentPage < listOfScreen.length - 1) {
      pageController.animateToPage(_currentPage + 1,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      pageController.animateToPage(_currentPage - 1,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPage = pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(    //la barra di navigazione posizionata in basso alla schermata
        style: TabStyle.fixedCircle,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          //TabItem(icon: Icons.map, title: 'Discovery'),
          TabItem(icon: Icons.add, title: 'Add'), //schermata per aggiungere una nuova ricetta da parte dell'utente
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ClassProfileUser()));
            }
          });
        },
      ),
      body: Stack(
        children: [
          Image.asset("images/image_backgound_screen_deatils_repicies.png"),
          PageView(
            controller: pageController,
            children: listOfScreen,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: Container(
                      width: 55,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Text("<", style: TextStyle(fontSize: 25),),
                    ),
                    onTap: (){
                      _previousPage();
                    },
                  ),
                  InkWell(
                    child: Container(
                      width: 55,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Text(">", style: TextStyle(fontSize: 25),),
                    ),
                    onTap: (){
                      _nextPage();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
