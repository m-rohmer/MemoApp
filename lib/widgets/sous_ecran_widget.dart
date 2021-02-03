import 'package:flutter/material.dart';
import 'package:memo_app/dto/idee.dart';
import 'package:memo_app/model/mes_idees.dart';
import 'package:memo_app/widgets/afficher_idees_widget.dart';
import 'package:provider/provider.dart';

class SousEcran extends StatefulWidget {
  SousEcran();

  @override
  _SousEcranState createState() => _SousEcranState();
}

class _SousEcranState extends State<SousEcran> {
  _SousEcranState();

  @override
  Widget build(BuildContext context) {
    var idees = context.watch<MesIdeesModel>();
    Idee nouvIdee = idees.getIdeeEnCours();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.post_add),
          onPressed: () => _associerIdees(context),
        ),
        title: Text('Associations d\'idées'),
      ),
      body: (nouvIdee.associations.isEmpty)
          ? Text('Aucune idée associée')
          : AfficherIdees(
              idees: idees.getIdeesAssociees(nouvIdee),
            ),
    );
  }

  void _associerIdees(BuildContext context) {
    var idees = context.read<MesIdeesModel>();
    Idee nouvIdee = idees.getIdeeEnCours();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(nouvIdee.titre.isEmpty
                ? 'Quelles idées associer ?'
                : 'Quelles idées associer à \'' + nouvIdee.titre + '\' ?'),
            content: _afficherIdees(context, idees),
          );
        });
  }

  Widget _afficherIdees(BuildContext context, MesIdeesModel idees) {
    if (!idees.hasIdeeSecondaire())
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('Aucune idée à associer'),
      );

    Idee nouvIdee = idees.getIdeeEnCours();
    final tiles = idees.getIdeesSecondaires().map(
      (Idee idee) {
        return StatefulBuilder(builder: (context, setState) {
          return ListTile(
            title: Text(
              idee.titre,
            ),
            trailing: Icon(
              nouvIdee.associations.contains(idee.id)
                  ? Icons.check_box_outlined
                  : Icons.check_box_outline_blank,
              color: nouvIdee.associations.contains(idee.id)
                  ? Colors.green
                  : Colors.grey,
            ),
            onTap: () {
              setState(() {
                nouvIdee.associations.contains(idee.id)
                    ? nouvIdee.associations.remove(idee.id)
                    : nouvIdee.associations.add(idee.id);
              });
              idees.ideeEnCours = nouvIdee;
            },
          );
        });
      },
    );
    final divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    return Container(
      height: 500,
      width: 300,
      child: ListView(children: divided).build(context),
    );
  }
}
