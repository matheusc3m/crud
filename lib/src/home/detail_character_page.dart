import 'package:crud/src/home/repository/home_repository_impl.dart';
import 'package:flutter/material.dart';

class DetailCharacterPage extends StatelessWidget {
  final Map _detail;

  DetailCharacterPage(this._detail);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: _detail["name"]);
    final ageController = TextEditingController(text: "${_detail["age"]}");

    final repository = HomeRepositoryImpl();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          repository.createCharacters(
            nameController.text,
            int.parse(ageController.text),
          );
        },
      ),
      appBar: AppBar(
        title: Text(_detail["name"]),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          _createCard("Nome", "name", nameController),
          _createCard("Idade", "age", ageController),
        ],
      ),
    );
  }

  Widget _createCard(
      String title, String trailing, TextEditingController controller) {
    return Card(
        child: TextField(
      controller: controller,
      decoration: InputDecoration(
          border: UnderlineInputBorder(),
          contentPadding: EdgeInsets.only(left: 20),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: title,
          hintText: _detail[trailing].toString()),
    ));
  }
}
