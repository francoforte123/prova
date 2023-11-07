import 'dart:io';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomePage.dart';

class ClassProfileUser extends StatefulWidget {
  ClassProfileUser({Key? key}) : super(key: key);

  Color? backgroundScaffold;
  Color? backgroundAppBar;
  XFile? image;
  final ImagePicker picker = ImagePicker();
  String newPassoword = "";
  String newEmail = "";
  String bioUser = "";
  String selectedColorKeyScaffold = 'backgroundScaffold';
  String selectedColorKeyAppBar = 'backgroundAppBar';

  @override
  State<ClassProfileUser> createState() => _ClassProfileUserState();
}

class _ClassProfileUserState extends State<ClassProfileUser> {

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newEmailController = TextEditingController();
  TextEditingController messageBio = TextEditingController();

  Color? backgroundScaffold;
  Color? backgroundAppBar;
  XFile? image;
  final ImagePicker picker = ImagePicker();
  String newPassoword = "";
  String newEmail = "";
  String bioUser = "";
  String selectedColorKeyScaffold = 'backgroundScaffold';
  String selectedColorKeyAppBar = 'backgroundAppBar';


  @override
  void initState() {
    super.initState();
    _loadSelectedColors();
  }

  //questa funzione di carica i dati selezionati (in questo caso i colori)
  Future<void> _loadSelectedColors() async {
    final prefs = await SharedPreferences.getInstance();
    final int? scaffoldColorValue = prefs.getInt(selectedColorKeyScaffold);
    final int? appBarColorValue = prefs.getInt(selectedColorKeyAppBar);
    if (scaffoldColorValue != null) {
      setState(() {
        backgroundScaffold = Color(scaffoldColorValue);
      });
    }
    if (appBarColorValue != null) {
      setState(() {
        backgroundAppBar = Color(appBarColorValue);
      });
    }
  }

  //questa funziona ti permette di salvare i dati selezionati (in questo caso i colori)
  Future<void> _saveSelectedColors(Color selectedScaffoldColor, Color selectedAppBarColor) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(selectedColorKeyScaffold, selectedScaffoldColor.value);
    await prefs.setInt(selectedColorKeyAppBar, selectedAppBarColor.value);
  }

  //funzione per prendere l'immagine tramite il telefono
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  //show popup dialog
  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.image),
                        SizedBox(width: 10),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.camera),
                        SizedBox(width: 10),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundScaffold ?? const Color.fromRGBO(19, 17, 17, 1), //const Color.fromRGBO(19, 17, 17, 1)
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ClassProfileUser()));
            }
          });
        },
      ),
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: backgroundAppBar ?? const Color.fromRGBO(42, 41, 41, 1),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 35),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text("Username", style: TextStyle(fontSize: 20, color: Colors.white)),
                  Text("(userName)", style: TextStyle(fontSize: 20, color: Colors.white)), //qui verrà messo l'username dell'utente
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                //il pulsante per caricare l'immagine come immagine del profilo
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orangeAccent,
                    ),
                    onPressed: () {
                      myAlert();
                    },
                    child: const Text('Upload Photo'),
                  ),
                  Container(
                    //se l'immagine non è stata messa, verrà mostrato un un contenitore con al centro una scritta
                    width: 100,
                    height: 70,
                    alignment: Alignment.center,
                    child: image != null
                        ? Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              shape: BoxShape.circle,
                            ),
                            child: Image.file(
                              File(image!.path),
                              fit: BoxFit.fitWidth,
                            ),
                          )
                        : DottedBorder(
                            strokeWidth: 1,
                            color: Colors.white,
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text("Upload Image", style: TextStyle(fontSize: 20, color: Colors.white)),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
              Padding(
                //questo era per dare la possibilità di cambiare il thema dell'intera app
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text("Theme", style: TextStyle(fontSize: 20, color: Colors.white)),
                    InkWell(
                      child: const Icon(
                        Icons.color_lens,
                        size: 50,
                        color: Colors.orangeAccent,
                      ),
                      onTap: () {
                        _showMyDialog();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              const Text("Settings", style: TextStyle(fontSize: 20, color: Colors.white)),
              Row(
                //in questa parte verrà messo la versione dell'app a mano a mano che verranno fatti dei aggiornamenti
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text("Version", style: TextStyle(fontSize: 20, color: Colors.white)),
                  Text("1.0.0", style: TextStyle(fontSize: 20, color: Colors.white)),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    //la possibilità di modificare l'indirizzo email (deve essere connesso al database per gestire la momorizzazione dell'email)
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Change Email", style: TextStyle(fontSize: 20, color: Colors.white)),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orangeAccent,
                        ),
                        onPressed: () {
                          alertDialogChangeEmail();
                        },
                        child: const Text("Click Me"),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                //la possibilità di modificare la password (deve essere connesso al database per gestire la momorizzazione della password)
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("Change Password", style: TextStyle(fontSize: 20, color: Colors.white)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orangeAccent,
                    ),
                    onPressed: () {
                      alertDialogChangePassword();
                    },
                    child: const Text("Click Me"),
                  ),
                ],
              ),
              //queste due righe di codice sono per esempio, poi verranno tolte in fase di rilascio dell'app
              Text("email: " + newEmail),
              Text("password: " + newPassoword),

              const Align(
                //questo è la bio dell'utente
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text("Bio", style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ),
              Padding(
                //qui è dove effettivamente andrà a inserire il testo della bio (inserire un meccanismo per persistere la bio dell'utente)
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: TextField(
                      controller: messageBio,
                      keyboardType: TextInputType.multiline,
                      maxLines: 30,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Write the bio",
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.orangeAccent,
                ),
                onPressed: () {
                  //una volta premuto il pulsante, ti porta a una schermata per le ricette create dall'utente stesso
                },
                child: const Text("My Recepies", style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("I Like Recepies", style: TextStyle(fontSize: 20, color: Colors.white)),
              const SizedBox(
                height: 12,
              ),
              Padding(
                //qui è un contenitore dove verranno mostrate le varie ricette piaciute all'utente
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.yellow,
                  //questo colore verrà tolto, l'ho messo tanto per vedere il contenitore padre/genitore in sè per sè
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        //qui verranno messi le varie ricette preferite
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {    //questa funzione ti mostra una serie di radio button con la possibilità di scegliere i colori
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose the theme for the AppBar of application', style: TextStyle(fontSize: 16),),
          content: SingleChildScrollView(
            child: Column(    //prima colonna per i colori dell'AppBar
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: const Color.fromRGBO(255, 127, 80, 1),
                                groupValue: backgroundAppBar,
                                onChanged: (Color? newColor){
                                  setState(() {
                                    backgroundAppBar= const Color.fromRGBO(255, 127, 80, 1);
                                    _saveSelectedColors(backgroundScaffold!, backgroundAppBar!);
                                  });
                                },
                              ),
                              const Text("Coral"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: const Color.fromRGBO(127, 255, 212, 1),
                                groupValue: backgroundAppBar,
                                onChanged: (Color? newColor){
                                  setState(() {
                                    backgroundAppBar= const Color.fromRGBO(127, 255, 212, 1);
                                    _saveSelectedColors(backgroundScaffold!, backgroundAppBar!);
                                  });
                                },
                              ),
                              const Text("Aquamarine"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: Colors.yellow,
                                groupValue: backgroundAppBar,
                                onChanged: (Color? newColor){
                                  setState(() {
                                    backgroundAppBar= Colors.yellow;
                                    _saveSelectedColors(backgroundScaffold!, backgroundAppBar!);
                                  });
                                },
                              ),
                              const Text("Yellow"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: const Color.fromRGBO(19, 17, 17, 1),
                                groupValue: backgroundAppBar,
                                onChanged: (Color? newColor){
                                  setState(() {
                                    backgroundAppBar= const Color.fromRGBO(19, 17, 17, 1);
                                    _saveSelectedColors(backgroundScaffold!, backgroundAppBar!);
                                  });
                                },
                              ),
                              const Text("Default"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: Colors.grey,
                                groupValue: backgroundAppBar,
                                onChanged: (Color? newColor){
                                  setState(() {
                                    backgroundAppBar= newColor;
                                    _saveSelectedColors(backgroundScaffold!, backgroundAppBar!);
                                  });
                                },
                              ),
                              const Text("Grey"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: const Color.fromRGBO(184, 115, 51, 1),
                                groupValue: backgroundAppBar,
                                onChanged: (Color? newColor){
                                  setState(() {
                                    backgroundAppBar= const Color.fromRGBO(184, 115, 51, 1);
                                    _saveSelectedColors(backgroundScaffold!, backgroundAppBar!);
                                  });
                                },
                              ),
                              const Text("Copper"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: const Color.fromRGBO(0, 139, 139, 1),
                                groupValue: backgroundAppBar,
                                onChanged: (Color? newColor){
                                  setState(() {
                                    backgroundAppBar= const Color.fromRGBO(0, 139, 139, 1);
                                    _saveSelectedColors(backgroundScaffold!, backgroundAppBar!);
                                  });
                                },
                              ),
                              const Text("Dark cyan"),
                            ],
                          ),
                        ],
                      ),
                      Column(   //seconda colonna per i colori dell'AppBar
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: const Color.fromRGBO(233, 214, 107, 1),
                                groupValue: backgroundAppBar,
                                onChanged: (Color? newColor){
                                  setState(() {
                                    backgroundAppBar= const Color.fromRGBO(233, 214, 107, 1);
                                    _saveSelectedColors(backgroundScaffold!, backgroundAppBar!);
                                  });
                                },
                              ),
                              const Text("Arylide\yellow"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: const Color.fromRGBO(161, 202, 241, 1),
                                groupValue: backgroundAppBar,
                                onChanged: (Color? newColor){
                                  setState(() {
                                    backgroundAppBar= const Color.fromRGBO(161, 202, 241, 1);
                                    _saveSelectedColors(backgroundScaffold!, backgroundAppBar!);
                                  });
                                },
                              ),
                              const Text("Baby blue eyes"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: const Color.fromRGBO(102, 153, 204, 1),
                                groupValue: backgroundAppBar,
                                onChanged: (Color? newColor){
                                  setState(() {
                                    backgroundAppBar= const Color.fromRGBO(102, 153, 204, 1);
                                    _saveSelectedColors(backgroundScaffold!, backgroundAppBar!);
                                  });
                                },
                              ),
                              const Text("Blue Gray"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: const Color.fromRGBO(145, 92, 131, 1),
                                groupValue: backgroundAppBar,
                                onChanged: (Color? newColor){
                                  setState(() {
                                    backgroundAppBar= const Color.fromRGBO(145, 92, 131, 1);
                                    _saveSelectedColors(backgroundScaffold!, backgroundAppBar!);
                                  });
                                },
                              ),
                              const Text("Antique\nfuchsia"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: Colors.brown,
                                groupValue: backgroundAppBar,
                                onChanged: (Color? newColor){
                                  setState(() {
                                    backgroundAppBar= Colors.brown;
                                    _saveSelectedColors(backgroundScaffold!, backgroundAppBar!);

                                  });
                                },
                              ),
                              const Text("Brown"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: Colors.cyan,
                                groupValue: backgroundAppBar,
                                onChanged: (Color? newColor){
                                  setState(() {
                                    backgroundAppBar= Colors.cyan;
                                    _saveSelectedColors(backgroundScaffold!, backgroundAppBar!);
                                  });
                                },
                              ),
                              const Text("Cyano"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: Colors.red,
                                groupValue: backgroundAppBar,
                                onChanged: (Color? newColor){
                                  setState(() {
                                    backgroundAppBar= newColor;
                                    _saveSelectedColors(backgroundScaffold!, backgroundAppBar!);
                                  });
                                },
                              ),
                              const Text("Red"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Text('Choose the theme for the Scaffold of application'),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(   //prima colonna per i colori dello Scaffold
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: const Color.fromRGBO(135, 50, 96, 1),
                                groupValue: backgroundScaffold,
                                onChanged: (Color? newColor){
                                  setState(() {
                                    backgroundScaffold= const Color.fromRGBO(135, 50, 96, 1);
                                    _saveSelectedColors(backgroundScaffold!, backgroundAppBar!);
                                  });
                                },
                              ),
                              const Text("Boysenberry"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: const Color.fromRGBO(133, 187, 101, 1),
                                groupValue: backgroundScaffold,
                                onChanged: (Color? newColor){
                                  setState(() {
                                    backgroundScaffold= const Color.fromRGBO(133, 187, 101, 1);
                                    _saveSelectedColors(backgroundScaffold!, backgroundAppBar!);
                                  });
                                },
                              ),
                              const Text("Dollar bill"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: const Color.fromRGBO(244, 187, 255, 1),
                                groupValue: backgroundScaffold,
                                onChanged: (Color? newColor){
                                  setState(() {
                                    backgroundScaffold= const Color.fromRGBO(244, 187, 255, 1);
                                    _saveSelectedColors(backgroundScaffold!, backgroundAppBar!);
                                  });
                                },
                              ),
                              const Text("Brillant lavender"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: const Color.fromRGBO(178, 255, 255, 1),
                                groupValue: backgroundScaffold,
                                onChanged: (Color? newColor){
                                  setState(() {
                                    backgroundScaffold= const Color.fromRGBO(178, 255, 255, 1);
                                    _saveSelectedColors(backgroundScaffold!, backgroundAppBar!);
                                  });
                                },
                              ),
                              const Text("Celeste"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: Colors.yellow,
                                groupValue: backgroundScaffold,
                                onChanged: (Color? newColor){
                                  setState(() {
                                    backgroundScaffold= Colors.yellow;
                                    _saveSelectedColors(backgroundScaffold!, backgroundAppBar!);
                                  });
                                },
                              ),
                              const Text("Yellow"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: const Color.fromRGBO(42, 41, 41, 1),
                                groupValue: backgroundScaffold,
                                onChanged: (Color? newColor){
                                  setState(() {
                                    backgroundScaffold= const Color.fromRGBO(42, 41, 41, 1);
                                    _saveSelectedColors(backgroundScaffold!, backgroundAppBar!);
                                  });
                                },
                              ),
                              const Text("Default"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: Colors.grey,
                                groupValue: backgroundScaffold,
                                onChanged: (Color? newColor){
                                  setState(() {
                                    backgroundScaffold= newColor;
                                    _saveSelectedColors(backgroundScaffold!, backgroundAppBar!);
                                  });
                                },
                              ),
                              const Text("Grey"),
                            ],
                          ),
                        ],
                      ),
                      Column(     //seconda colonna per i colori dello Scaffold
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: const Color.fromRGBO(80, 200, 120, 1),
                                groupValue: backgroundScaffold,
                                onChanged: (Color? newColor){
                                  setState(() {
                                    backgroundScaffold= const Color.fromRGBO(80, 200, 120, 1);
                                    _saveSelectedColors(backgroundScaffold!, backgroundAppBar!);
                                  });
                                },
                              ),
                              const Text("Emerald"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: const Color.fromRGBO(255, 215, 0, 1),
                                groupValue: backgroundScaffold,
                                onChanged: (Color? newColor){
                                  setState(() {
                                    backgroundScaffold= const Color.fromRGBO(255, 215, 0, 1);
                                    _saveSelectedColors(backgroundScaffold!, backgroundAppBar!);
                                  });
                                },
                              ),
                              const Text("Gold"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: const Color.fromRGBO(255, 167, 0, 1),
                                groupValue: backgroundScaffold,
                                onChanged: (Color? newColor){
                                  setState(() {
                                    backgroundScaffold= const Color.fromRGBO(255, 167, 0, 1);
                                    _saveSelectedColors(backgroundScaffold!, backgroundAppBar!);
                                  });
                                },
                              ),
                              const Text("Chocolate"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: const Color.fromRGBO(250, 214, 165, 1),
                                groupValue: backgroundAppBar,
                                onChanged: (Color? newColor){
                                  setState(() {
                                    backgroundAppBar= const Color.fromRGBO(250, 214, 165, 1);
                                    _saveSelectedColors(backgroundScaffold!, backgroundAppBar!);
                                  });
                                },
                              ),
                              const Text("Deep\nchampagne"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: Colors.brown,
                                groupValue: backgroundScaffold,
                                onChanged: (Color? newColor){
                                  setState(() {
                                    backgroundScaffold= Colors.brown;
                                    _saveSelectedColors(backgroundScaffold!, backgroundAppBar!);
                                  });
                                },
                              ),
                              const Text("Brown"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: Colors.cyan,
                                groupValue: backgroundScaffold,
                                onChanged: (Color? newColor){
                                  setState(() {
                                    backgroundScaffold= Colors.cyan;
                                    _saveSelectedColors(backgroundScaffold!, backgroundAppBar!);
                                  });
                                },
                              ),
                              const Text("Cyano"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: Colors.red,
                                groupValue: backgroundScaffold,
                                onChanged: (Color? newColor){
                                  setState(() {
                                    backgroundScaffold= newColor;
                                    _saveSelectedColors(backgroundScaffold!, backgroundAppBar!);
                                  });
                                },
                              ),
                              const Text("Red"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> alertDialogChangeEmail() {   //questa funziona ti permette di cambiare l'email (ovviamente l'email và memorizzata nel db)
    return showDialog(
        context: context,
        builder: (BuildContext contex) {
          return FractionallySizedBox(
            heightFactor: 0.45,
            child: AlertDialog(
              content: Column(
                children: [
                  const Text("New Email:"),
                  Container(
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: TextField(
                        controller: newEmailController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {     //una volta premuto il pulsante, viene cambiata l'email, il campo di testo viene pulito e verrà chiusa l'alert dialog
                      setState(() {
                        newEmail = newEmailController.text;
                        newEmailController.clear();
                        Navigator.of(context).pop(true);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(     //verrà mostrato un messaggio per il salvataggio della nuova email
                        const SnackBar(
                          content: Text("The email is changed"),
                        ),
                      );
                    },
                    child: const Text("Change"),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        });
  }

  Future<void> alertDialogChangePassword() {      //questa funziona ti permette di cambiare l'email (ovviamente l'email và memorizzata nel db)
    return showDialog(
        context: context,
        builder: (BuildContext contex) {
          return FractionallySizedBox(
            heightFactor: 0.45,
            child: AlertDialog(
              content: Column(
                children: [
                  const Text("New Password:"),
                  Container(
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: TextField(
                        controller: newPasswordController,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {       //una volta premuto il pulsante, viene cambiata la password, il campo di testo viene pulito e verrà chiusa l'alert dialog
                      setState(() {
                        newPassoword = newPasswordController.text;
                        newPasswordController.clear();
                        Navigator.of(context).pop(true);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(   //verrà mostrato un messaggio per il salvataggio della nuova password
                        const SnackBar(
                          content: Text("The password is changed"),
                        ),
                      );
                    },
                    child: const Text("Change"),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        });
  }
}
