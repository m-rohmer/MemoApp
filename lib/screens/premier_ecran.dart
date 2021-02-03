import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:memo_app/common/manipuler_idee.dart';
import 'package:memo_app/model/mes_idees.dart';
import 'package:memo_app/widgets/afficher_idees_widget.dart';
import 'package:memo_app/dto/idee.dart';

class PremierEcran extends StatefulWidget {
  @override
  _PremierEcranState createState() => _PremierEcranState();
}

class _PremierEcranState extends State<PremierEcran> {
  @override
  Widget build(BuildContext context) {
    var idees = context.watch<MesIdeesModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Mes idées'),
        actions: [
          IconButton(
            onPressed: () {
              modifierIdee(context, new Idee());
            },
            icon: Icon(Icons.note_add),
          ),
        ],
      ),
      body: (idees.isEmpty())
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Ici mes futures idées !'),
            )
          : AfficherIdees(
              idees: idees.getIdees(),
            ),
    );
  }
}
