import 'package:animations/animations.dart';
import 'package:crud/src/app/detail_character_page.dart';
import 'package:crud/src/app/repository/app_repository_impl.dart';
import 'package:flutter/material.dart';

class CharacterPage extends StatelessWidget {
  var lista = ["1", "2"];
  @override
  Widget build(BuildContext context) {
    final repository = AppRepositoryImpl();

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailCharacterPage(
                        "",
                        "",
                        isEdit: false,
                      )),
            );
          },
          child: Icon(Icons.add),
        ),
        body: FutureBuilder(
          future: repository.getCharacters(),
          builder: (context, snapshot) {
            final characters = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                    strokeWidth: 10,
                  ),
                );
              default:
                if (snapshot.hasError)
                  return Text("Ops ocorreu um erro");
                else
                  return ListView.builder(
                      padding: EdgeInsets.all(10.0),
                      itemCount: characters.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: OpenContainer(
                              transitionDuration: Duration(milliseconds: 600),
                              transitionType:
                                  ContainerTransitionType.fadeThrough,
                              closedElevation: 2,
                              closedBuilder: (context, action) {
                                return ListTile(
                                  title: Text(characters[index]['name']),
                                );
                              },
                              openBuilder: (context, action) {
                                return DetailCharacterPage(
                                  characters[index]['name'],
                                  characters[index]['age'].toString(),
                                  isEdit: true,
                                  id: characters[index]['id'],
                                );
                              }),
                        );
                      });
            }
          },
        ));
  }
}
