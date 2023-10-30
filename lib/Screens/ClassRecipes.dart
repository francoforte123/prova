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
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("..."),
              ),
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                    "Proin varius nulla non orci hendrerit ullamcorper. Donec "
                    "turpis nibh, maximus et neque convallis, accumsan aliquam "
                    "ex. Nunc eget pellentesque risus. Nam scelerisque nisi sed "
                    "mauris vestibulum consequat. Donec massa augue, bibendum "
                    "sit amet ipsum eu, euismod gravida erat.", style: TextStyle(fontSize: 15),),
              ),
            ],
          ),
          Align(
           alignment: Alignment.bottomCenter,
           child: Text("${1}/${3.toString()}"),
          ),
        ],
      ),
    ),
    Container(
      child: Stack(
        children: [
          Column(
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                    "Proin varius nulla non orci hendrerit ullamcorper. Donec "
                    "turpis nibh, maximus et neque convallis, accumsan aliquam "
                    "ex. Nunc eget pellentesque risus. Nam scelerisque nisi sed "
                    "mauris vestibulum consequat. Donec massa augue, bibendum "
                    "sit amet ipsum eu, euismod gravida erat.", style: TextStyle(fontSize: 15)),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text("${2}/${3.toString()}"),
          ),
        ],
      ),
    ),
    Container(
      child: Stack(
        children: [
          Column(
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                    "Proin varius nulla non orci hendrerit ullamcorper. Donec "
                    "turpis nibh, maximus et neque convallis, accumsan aliquam "
                    "ex. Nunc eget pellentesque risus. Nam scelerisque nisi sed "
                    "mauris vestibulum consequat. Donec massa augue, bibendum "
                    "sit amet ipsum eu, euismod gravida erat.", style: TextStyle(fontSize: 15)),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text("${3}/${3.toString()}"),
          ),
        ],
      ),
    ),
  ];

  //queste sono le funzioni per permettere di andare avanti o indietro tra le varie pagine della ricetta
  void _nextPage() {
    if (_currentPage < listOfScreen.length - 1) {
      pageController.animateToPage(_currentPage + 1,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      pageController.animateToPage(_currentPage - 1,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
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
                      builder: (context) => const ClassProfileUser()));
            }
          });
        },
      ),
      appBar: AppBar(
        title: const Text("(nome ricetta)"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(189, 205, 208, 1),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(    //la possibilità di creare uno "intro slider" usando un widget anzichè un pacchetto dedicato
              controller: pageController,
              children: listOfScreen,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  child: Container(   //questo è la freccia per andare indietro tra le varie schermate della ricetta
                    width: 55,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(78, 255, 181, 1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text(
                      "<",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  onTap: () {
                    _previousPage();
                  },
                ),
                InkWell(
                  child: Container(     //questo è la freccia per andare avanti tra le varie schermate della ricetta
                    width: 55,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(78, 255, 181, 1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text(
                      ">",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  onTap: () {
                    _nextPage();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
