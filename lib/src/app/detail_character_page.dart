import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:crud/src/app/main_page.dart';
import 'package:crud/src/app/repository/app_repository_impl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailCharacterPage extends StatefulWidget {
  String name;
  String age;
  bool isEdit;
  int id;

  DetailCharacterPage(this.name, this.age, {this.isEdit, this.id});

  @override
  _DetailCharacterPageState createState() => _DetailCharacterPageState();
}

class _DetailCharacterPageState extends State<DetailCharacterPage> {
  @override
  Widget build(BuildContext context) {
    final nameController =
        TextEditingController(text: widget.name != "" ? widget.name : "");
    final ageController =
        TextEditingController(text: widget.age != "" ? widget.age : "");

    final repository = AppRepositoryImpl();
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do personagem"),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          _customTextField("Nome", "name", nameController),
          _customTextField("Idade", "age", ageController),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: widget.isEdit == true
                ? MainAxisAlignment.spaceAround
                : MainAxisAlignment.center,
            children: [
              CupertinoButton(
                color: Colors.green,
                onPressed: () {
                  widget.isEdit == false
                      ? repository.createCharacters(
                          nameController.text,
                          int.parse(ageController.text),
                        )
                      : repository.updateCharacters(widget.id,
                          nameController.text, int.parse(ageController.text));
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainPage(),
                      ),
                      (Route<dynamic> route) => false);
                },
                child: Icon(Icons.save),
              ),
              widget.isEdit == true
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
                            btnOkOnPress: () {
                              repository.deleteCharacters(widget.id);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainPage(),
                                  ),
                                  (Route<dynamic> route) => false);
                            },
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

  Widget _customTextField(
      String title, String trailing, TextEditingController controller) {
    return Card(
        child: TextField(
            keyboardType:
                title == "Idade" ? TextInputType.number : TextInputType.text,
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
