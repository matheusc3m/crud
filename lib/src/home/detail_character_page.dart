import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:crud/src/home/repository/home_repository_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailCharacterPage extends StatelessWidget {
  String name;
  String age;
  bool isEdit;

  DetailCharacterPage(this.name, this.age, {this.isEdit});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: name != "" ? name : "");
    final ageController = TextEditingController(text: age != "" ? age : "");

    final repository = HomeRepositoryImpl();
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do personagem"),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          _createCard("Nome", "name", nameController),
          _createCard("Idade", "age", ageController),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: isEdit == true
                ? MainAxisAlignment.spaceAround
                : MainAxisAlignment.center,
            children: [
              CupertinoButton(
                color: Colors.green,
                onPressed: () {
                  repository.createCharacters(
                    nameController.text,
                    int.parse(ageController.text),
                  );
                },
                child: Icon(Icons.save),
              ),
              isEdit == true
                  ? CupertinoButton(
                      color: Colors.red,
                      onPressed: () {
                        AwesomeDialog(
                            context: context,
                            animType: AnimType.SCALE,
                            dialogType: DialogType.WARNING,
                            body: Center(
                              child: Text(
                                'Tem certeza que deseja apagar?',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            title: 'This is Ignored',
                            desc: 'This is also Ignored',
                            btnOkOnPress: () {},
                            btnOkText: "Sim",
                            btnCancelOnPress: () {},
                            btnCancelText: "Cancelar")
                          ..show();
                      },
                      child: Icon(Icons.delete),
                    )
                  : SizedBox(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _createCard(
      String title, String trailing, TextEditingController controller) {
    return Card(
        child: TextField(
            autofocus: true,
            controller: controller,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              contentPadding: EdgeInsets.only(left: 20),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: title,
            )));
  }
}
