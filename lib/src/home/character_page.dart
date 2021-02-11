import 'package:crud/src/home/detail_character_page.dart';
import 'package:crud/src/home/repository/home_repository_impl.dart';
import 'package:flutter/material.dart';

class CharacterPage extends StatelessWidget {
  var lista = ["1", "2"];
  @override
  Widget build(BuildContext context) {
    final repository = HomeRepositoryImpl();

    return Scaffold(
        appBar: AppBar(
          title: Text("Listagem"),
        ),
        body: FutureBuilder(
          future: repository.getCharacters(),
          builder: (context, snapshot) {
            final characters = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Container(
                  width: 300.0,
                  height: 300.0,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                    strokeWidth: 5.0,
                  ),
                );
              default:
                if (snapshot.hasError)
                  return Container();
                else
                  return ListView.builder(
                      padding: EdgeInsets.all(10.0),
                      itemCount: characters.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(characters[index]['name']),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailCharacterPage(
                                          characters[index])));
                            },
                          ),
                        );
                      });
            }
          },
        ));
  }
}
