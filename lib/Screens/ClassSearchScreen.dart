import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClassSearchScreen extends StatefulWidget {
  const ClassSearchScreen({Key? key}) : super(key: key);

  @override
  State<ClassSearchScreen> createState() => _ClassSearchScreenState();
}

class _ClassSearchScreenState extends State<ClassSearchScreen> {

  TextEditingController searchBarController= TextEditingController();
  String searchValue="";
  List<String> listOfTitleRecipes=[   //questa è la lista dei titoli delle ricette, bisogna inserire i titoli quì per far funzionare la "search bar"
    "carbonara",
    "matriciana",
    "tiramisù",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 1),
          ),
          child: Autocomplete<String>(optionsBuilder:
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
          },
            onSelected: (String selection) {
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
    );
  }
}
