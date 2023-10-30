import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prova/Screens/HomePage.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 7), (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 5),
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
    return Scaffold(
      backgroundColor: const Color.fromRGBO(209, 205, 239, 1),
      body: Center(
        child: SlideTransition(
          position: _offsetAnimation,
            child: Image.asset("images/icon_app.png", width: 230,),
        ),
      ),
    );
  }
}
