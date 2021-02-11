import 'package:crud/src/home/character_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 0;
  PageController _controller = PageController(
    initialPage: 0,
  );
  final List<Widget> _screens = [Text("Bem vindo!"), CharacterPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          pageSnapping: false,
          physics: NeverScrollableScrollPhysics(),
          controller: _controller,
          children: [_screens[0], _screens[1]]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: page,
        onTap: (int index) {
          setState(() {
            setState(() {
              page = index;
            });

            _controller.animateToPage(
              index,
              curve: Curves.fastOutSlowIn,
              duration: const Duration(milliseconds: 400),
            );
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Personagens")
        ],
      ),
    );
  }
}
