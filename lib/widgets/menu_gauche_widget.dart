import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:memo_app/common/theme.dart';
import 'package:memo_app/dto/idee.dart';
import 'package:memo_app/model/mes_idees.dart';

import 'devenir_idee_principale_widget.dart';

class MenuGauche extends StatefulWidget {
  MenuGauche();

  @override
  _MenuGaucheState createState() => _MenuGaucheState();
}

class _MenuGaucheState extends State<MenuGauche> {
  _MenuGaucheState();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: _construireMenu(context),
          ),
        )
      ],
    );
  }

  List<Widget> _construireMenu(BuildContext context) {
    List<Widget> builder = [];
    var idees = context.watch<MesIdeesModel>();
    Idee enCours = idees.getIdeeEnCours();

    final categorieController = TextEditingController();
    categorieController.text = enCours.categorie;

    builder.add(ListTile(
      title: enCours.titre.isNotEmpty
          ? Text(
              enCours.titre,
              style: styleTitreMenu,
            )
          : Text(
              'Mon idée',
              style: styleParDefaut,
            ),
      trailing: DevenirIdeePrincipale(),
    ));

    builder.add(
      ListTile(
        leading: Icon(Icons.label),
        title: enCours.categorie.isEmpty
            ? Text(
                'Catégorie',
                style:
                    TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
              )
            : Text(enCours.categorie),
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Définir la catégorie'),
                  content: _construireListeCategories(context),
                );
              });
        },
      ),
    );

    if (builder.isNotEmpty) {
      builder.add(Divider(
        height: 1,
        thickness: 1,
      ));
    }
    builder.add(
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Etiquettes',
        ),
      ),
    );
    for (var etiquette in enCours.etiquettes) {
      builder.add(Text(etiquette));
    }
    return builder;
  }

  Widget _construireListeCategories(BuildContext context) {
    var idees = context.watch<MesIdeesModel>();
    Idee enCours = idees.getIdeeEnCours();
    final categorieController = TextEditingController();
    var nouvCategorie;

    var tiles = idees.getCategories().map(
      (String categorie) {
        return StatefulBuilder(builder: (context, setState) {
          return ListTile(
            title: Text(
              categorie,
            ),
            trailing: Icon(
              categorie == enCours.categorie
                  ? Icons.check_box_outlined
                  : Icons.check_box_outline_blank,
              color:
                  categorie == enCours.categorie ? Colors.green : Colors.grey,
            ),
            onTap: () {
              setState(() {
                categorie == enCours.categorie
                    ? enCours.categorie = ''
                    : enCours.categorie = categorie;
              });
              idees.ideeEnCours = enCours;
            },
          );
        });
      },
    ).toList();

    tiles.insert(0, StatefulBuilder(builder: (context, setState) {
      return ListTile(
        title: TextField(
          maxLines: 1,
          decoration: InputDecoration(
            labelText: 'nouvelle catégorie',
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
          controller: categorieController,
          onChanged: (text) {
            nouvCategorie = text;
          },
        ),
        trailing: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            setState(() {
              enCours.categorie = nouvCategorie;
              categorieController.clear();
            });
            idees.ideeEnCours = enCours;
          },
        ),
      );
    }));

    return Container(
      height: 500,
      width: 300,
      child: ListView(children: tiles).build(context),
    );
  }
}
