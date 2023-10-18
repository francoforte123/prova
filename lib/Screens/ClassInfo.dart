import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Classinfo extends StatefulWidget {
  const Classinfo({Key? key}) : super(key: key);

  @override
  State<Classinfo> createState() => _ClassinfoState();
}

class _ClassinfoState extends State<Classinfo> {

  Color backgroundOfColorContainer= Colors.white;
  String pathImage="";
  List<Widget> listOfAnimation=[SlideTransitionExample()];//le varie animazioni
  int selectedEffect=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("scegli tu le varie informazioni", style: TextStyle(fontSize: 25),),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("colore per lo sfondo della schermata", style: TextStyle(fontSize: 16),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
              child: Container(
                width: double.infinity,
                height: 350,
                decoration: BoxDecoration(
                  color: backgroundOfColorContainer,
                  border: Border.all(width: 1),
                ),
                  child: Image.asset(pathImage),
                ),
              ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("colore per lo sfondo della schermata", style: TextStyle(fontSize: 16),),
            ),
            RadioListTile(
                title: const Text("Azzurro Savoia"),
                value: const Color.fromRGBO(99, 151, 208, 1),
                groupValue: backgroundOfColorContainer,
                onChanged: (newValue){
                  setState(() {
                    backgroundOfColorContainer= newValue!;
                  });
                }
            ),
            RadioListTile(
                title: const Text("Camoscio"),
                value: const Color.fromRGBO(240, 220, 130, 1),
                groupValue: backgroundOfColorContainer,
                onChanged: (newValue){
                  setState(() {
                    backgroundOfColorContainer= newValue!;
                  });
                }
            ),
            RadioListTile(
                title: const Text("Crema"),
                value: const Color.fromRGBO(255, 253, 208, 1),
                groupValue: backgroundOfColorContainer,
                onChanged: (newValue){
                  setState(() {
                    backgroundOfColorContainer= newValue!;
                  });
                }
            ),
            RadioListTile(
                title: const Text("Glicine"),
                value: const Color.fromRGBO(201, 160, 220, 1),
                groupValue: backgroundOfColorContainer,
                onChanged: (newValue){
                  setState(() {
                    backgroundOfColorContainer= newValue!;
                  });
                }
            ),
            RadioListTile(
                title: const Text("Carta Da Zucchero"),
                value: const Color.fromRGBO(224, 255, 255, 1),
                groupValue: backgroundOfColorContainer,
                onChanged: (newValue){
                  setState(() {
                    backgroundOfColorContainer= newValue!;
                  });
                }
            ),
            const Divider(height: 20, color: Colors.black,),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("icone dell'app", style: TextStyle(fontSize: 16),),
            ),
            RadioListTile(
                title: const Text("icona 1"),
                value: "images/cook-book.png",
                groupValue: pathImage,
                onChanged: (newValue){
                  setState(() {
                    pathImage= newValue!;
                  });
                }
            ),
            RadioListTile(
                title: const Text("icona 2"),
                value: "images/recipe.png",
                groupValue: pathImage,
                onChanged: (newValue){
                  setState(() {
                    pathImage= newValue!;
                  });
                }
            ),
            RadioListTile(
                title: const Text("icona 3"),
                value: "images/book.png",
                groupValue: pathImage,
                onChanged: (newValue){
                  setState(() {
                    pathImage= newValue!;
                  });
                }
            ),
            RadioListTile(
                title: const Text("icona 4"),
                value: "images/recipe-book.png",
                groupValue: pathImage,
                onChanged: (newValue){
                  setState(() {
                    pathImage= newValue!;
                  });
                }
            ),
            const Divider(height: 20, color: Colors.black,),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("nomi dell'app", style: TextStyle(fontSize: 16),),
            ),
            Column(
              children: const [
                Text("RicettarioDelizioso"),
                SizedBox(height: 10,),
                Text("GourmetFacile"),
                SizedBox(height: 10,),
                Text("CookingTime"),
                SizedBox(height: 10,),
                Text("RicetteGourmand"),
              ],
            ),
            /*const Divider(height: 20, color: Colors.black,),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("effetti animati sull'icona dell'app", style: TextStyle(fontSize: 16),),
            ),*/
            /*RadioListTile(
                title: const Text("Fade Transition"),
                value: ,
                groupValue: ,
                onChanged: (newValue){
                  setState(() {
                    = newValue!;
                  });
                }
            ),*/
           /* RadioListTile(
                title: const Text("Slide Transition"),
                value: 0,
                groupValue: selectedEffect,
                onChanged: (newValue){
                  setState(() {
                    selectedEffect = newValue!;
                  });
                }
            ),*/
            /*RadioListTile(
                title: const Text("Size Transition"),
                value: ,
                groupValue: ,
                onChanged: (newValue){
                  setState(() {
                    = newValue!;
                  });
                }
            ),*/
            /*RadioListTile(
                title: const Text("Scale Transition"),
                value: ,
                groupValue: ,
                onChanged: (newValue){
                  setState(() {
                    = newValue!;
                  });
                }
            ),*/
            /*RadioListTile(
                title: const Text("Rotation Transition"),
                value: ,
                groupValue: ,
                onChanged: (newValue){
                  setState(() {
                    = newValue!;
                  });
                }
            ),*/
            ],
            ),

      ),
        );


  }
}


class SlideTransitionExample extends StatefulWidget {
  const SlideTransitionExample({super.key});

  @override
  State<SlideTransitionExample> createState() => _SlideTransitionExampleState();
}

class _SlideTransitionExampleState extends State<SlideTransitionExample>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.5, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticIn,
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: FlutterLogo(size: 150.0),
      ),
    );
  }
}
