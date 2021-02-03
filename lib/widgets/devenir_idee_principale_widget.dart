import 'package:flutter/material.dart';
import 'package:memo_app/common/manipuler_idee.dart';
import 'package:memo_app/dto/idee.dart';
import 'package:provider/provider.dart';

import 'package:memo_app/model/mes_idees.dart';

class DevenirIdeePrincipale extends StatefulWidget {
  DevenirIdeePrincipale();

  @override
  _DevenirIdeePrincipaleState createState() => _DevenirIdeePrincipaleState();
}

class _DevenirIdeePrincipaleState extends State<DevenirIdeePrincipale> {
  _DevenirIdeePrincipaleState();

  @override
  Widget build(BuildContext context) {
    var idees = context.watch<MesIdeesModel>();
    Idee ideeEnCours = idees.getIdeeEnCours();

    return IconButton(
      icon: Icon(
        ideeEnCours.estIdeePrincipale ? Icons.star : Icons.star_border,
        color: ideeEnCours.estIdeePrincipale ? Colors.yellow : Colors.grey,
      ),
      onPressed: () {
        if (idees.peutDevenirIdeePrincipale(ideeEnCours)) {
          setState(() {
            ideeEnCours.estIdeePrincipale = !ideeEnCours.estIdeePrincipale;
          });
          idees.ideeEnCours = ideeEnCours;
        } else {
          nePeutPasDevenirIdeePrincipale(context);
        }
      },
      tooltip: 'Définir en tant qu\'idée principale',
    );
  }
}
