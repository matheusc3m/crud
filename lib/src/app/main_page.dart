import 'package:crud/src/app/home_page.dart';
import 'package:flutter/material.dart';

import 'character_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int page = 0;
  PageController _controller = PageController(
    initialPage: 0,
  );
  final List<Widget> _screens = [HomePage(), CharacterPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        elevation: 2,
        child: SafeArea(
          child: Column(
            children: [
              Card(
                  child: InkWell(
                onTap: () {
                  _controller.jumpToPage(0);
                  setState(() {
                    page = 0;
                  });
                  Navigator.of(context).pop();
                },
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Home"),
                ),
              )),
              Card(
                  child: InkWell(
                onTap: () {
                  _controller.jumpToPage(1);
                  setState(() {
                    page = 1;
                  });
                  Navigator.of(context).pop();
                },
                child: ListTile(
                  leading: Icon(Icons.supervised_user_circle),
                  title: Text("Personagens"),
                ),
              ))
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text("Bem vindo!"),
      ),
      body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _controller,
          children: [_screens[0], _screens[1]]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: page,
        onTap: (int index) {
          setState(() {
            page = index;
          });

          _controller.animateToPage(
            index,
            curve: Curves.fastOutSlowIn,
            duration: const Duration(milliseconds: 400),
          );
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle), label: "Personagens")
        ],
      ),
    );
  }
}
