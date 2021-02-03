import 'package:flutter/material.dart';
import 'package:memo_app/common/manipuler_idee.dart';

class ActionIdee {
  const ActionIdee({this.nom, this.execution});
  final String nom;
  final Function execution;
}

const List<ActionIdee> actions = const <ActionIdee>[
  const ActionIdee(nom: 'modifier catégorie', execution: defautAction),
  const ActionIdee(nom: 'gérer étiquettes', execution: defautAction),
  const ActionIdee(nom: 'changer d\'état', execution: defautAction),
  const ActionIdee(nom: 'supprimer', execution: supprimerIdee),
  const ActionIdee(nom: 'dupliquer', execution: dupliquerIdee),
];

class ActionsIdeesPremierEcran extends StatelessWidget {
  const ActionsIdeesPremierEcran({Key key, this.action}) : super(key: key);

  final ActionIdee action;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.greenAccent,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(action.nom),
          ],
        ),
      ),
    );
  }
}
