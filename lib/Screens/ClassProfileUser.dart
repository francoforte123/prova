import 'dart:io';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'HomePage.dart';

class ClassProfileUser extends StatefulWidget {
  const ClassProfileUser({Key? key}) : super(key: key);

  @override
  State<ClassProfileUser> createState() => _ClassProfileUserState();
}

class _ClassProfileUserState extends State<ClassProfileUser> {

  //Color? backgroundColorScreenTheme;
  TextEditingController newPasswordController= TextEditingController();
  TextEditingController newEmailController= TextEditingController();
  TextEditingController messageBio= TextEditingController();

  XFile? image;
  final ImagePicker picker = ImagePicker();
  String newPassoword="";
  String newEmail="";
  String bioUser="";

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
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
    return Container(
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
            title: const Text("Profile"),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: const Color.fromRGBO(189, 205, 208, 1),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text("Username", style: TextStyle(fontSize: 20)),
                      Text("(userName)"),   //qui verrà messo l'username dell'utente
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(    //il pulsante per caricare l'immagine come immagine del profilo
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          myAlert();
                        },
                        child: const Text('Upload Photo'),
                      ),
                      Container(    //se l'immagine non è stata messa, verrà mostrato un un contenitore con al centro una scritta
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
                          child: const Center(
                            child: Text("Upload Image"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  /*Padding(    //questo era per dare la possibilità di cambiare il thema dell'intera app
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text("Theme"),
                        InkWell(
                          child: const Icon(Icons.color_lens, size: 50,),
                          onTap: (){
                            _showMyDialog();
                          },
                        ),
                      ],
                    ),
                  ),*/
                  const SizedBox(height: 15),
                  const Text("Settings", style: TextStyle(fontSize: 20)),
                  Row(    //in questa parte verrà messo la versione dell'app a mano a mano che verranno fatti dei aggiornamenti
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text("Version", style: TextStyle(fontSize: 20)),
                      Text("1.0.0", style: TextStyle(fontSize: 20)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(    //la possibilità di modificare l'indirizzo email (deve essere connesso al database per gestire la momorizzazione dell'email)
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Change Email", style: TextStyle(fontSize: 20)),
                      ElevatedButton(
                        onPressed: (){
                          alertDialogChangeEmail();
                        },
                        child: const Text("Click Me"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(      //la possibilità di modificare la password (deve essere connesso al database per gestire la momorizzazione della password)
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Change Password", style: TextStyle(fontSize: 20)),
                      ElevatedButton(
                        onPressed: (){
                          alertDialogChangePassword();
                        },
                        child: const Text("Click Me"),
                      ),
                    ],
                  ),
                  //queste due righe di codice sono per esempio, poi verranno tolte in fase di rilascio dell'app
                  Text("email: " + newEmail),
                  Text("password: " + newPassoword),

                  const Align(    //questo è la bio dell'utente
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text("Bio", style: TextStyle(fontSize: 20)),
                    ),
                  ),
                  Padding(      //qui è dove effettivamente andrà a inserire il testo della bio (inserire un meccanismo per persistere la bio dell'utente)
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
                  const SizedBox(height: 12,),
                  ElevatedButton(
                    onPressed: (){
                      //una volta premuto il pulsante, ti porta a una schermata per le ricette create dall'utente stesso
                    },
                    child: const Text("My Recepies"),
                  ),
                  const SizedBox(height: 20,),
                  const Text("I Like Recepies", style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 12,),
                  Padding(    //qui è un contenitore dove verranno mostrate le varie ricette piaciute all'utente
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.yellow,   //questo colore verrà tolto, l'ho messo tanto per vedere il contenitore padre/genitore in sè per sè
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
        ),
      );
  }

  /*Future<void> _showMyDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose the theme for the application'),
          content: Column(
            children: [

            ],
          ),
        );
      },
    );
  }*/

  Future<void> alertDialogChangeEmail(){
    return showDialog(
        context: context,
        builder: (BuildContext contex){
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
                    onPressed: (){
                      setState(() {
                        newEmail= newEmailController.text;
                        newEmailController.clear();
                        Navigator.of(context).pop(true);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
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
        }
    );
  }

  Future<void> alertDialogChangePassword(){
    return showDialog(
        context: context,
        builder: (BuildContext contex){
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
                    onPressed: (){
                      setState(() {
                        newPassoword= newPasswordController.text;
                        newPasswordController.clear();
                        Navigator.of(context).pop(true);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
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
        }
    );
  }
}
