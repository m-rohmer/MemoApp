import 'package:flutter/material.dart';
import 'package:memo_app/common/manipuler_idee.dart';
import 'package:memo_app/common/theme.dart';
import 'package:memo_app/common/utils.dart';
import 'package:memo_app/dto/idee.dart';

import 'actions_idees_premier_ecran.dart';

class AfficherIdees extends StatefulWidget {
  final List<Idee> idees;
  AfficherIdees({Key key, @required this.idees}) : super(key: key);

  @override
  _AfficherIdeesState createState() => _AfficherIdeesState(idees);
}

class _AfficherIdeesState extends State<AfficherIdees> {
  final List<Idee> idees;
  _AfficherIdeesState(this.idees);

  @override
  Widget build(BuildContext context) {
    final tiles = idees.map(
      (Idee idee) {
        return ListTile(
          title: Row(children: [
            Text(
              idee.titre,
              style: idee.estIdeePrincipale
                  ? styleTitrePrincipale
                  : styleParDefaut,
            ),
            Text(' '),
            Text(
              idee.categorie,
              style: styleCategorie,
            ),
          ]),
          subtitle: Text(
            miseEnFormeText(idee.corps),
          ),
          trailing: PopupMenuButton<ActionIdee>(
            tooltip: 'Ouvrir menu',
            onSelected: (ActionIdee action) {
              action.execution(context, idee);
            },
            itemBuilder: (BuildContext context) {
              return actions.skip(0).map((ActionIdee action) {
                return PopupMenuItem<ActionIdee>(
                  height: 12,
                  value: action,
                  child: Text(action.nom),
                );
              }).toList();
            },
          ),
          onTap: () {
            modifierIdee(context, idee);
          },
          onLongPress: () {
            _gererIdee(idee);
          },
        );
      },
    );
    final divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();
    return ListView(children: divided).build(context);
  }

  void _gererIdee(Idee idee) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Que voulez-vous faire (poil au derrière) ?'),
              actions: [
                FlatButton(
                  onPressed: () {
                    dupliquerIdee(context, idee);
                    Navigator.pop(context);
                  },
                  child: Text('Dupliquer l\'idée ?'),
                ),
                FlatButton(
                  onPressed: () {
                    supprimerIdee(context, idee);
                    Navigator.pop(context);
                  },
                  child: Text('La supprimer définitivement ?'),
                ),
              ]);
        });
  }
}
