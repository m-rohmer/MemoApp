import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:memo_app/dto/idee.dart';
import 'package:memo_app/model/mes_idees.dart';
import 'package:memo_app/screens/idee_ecran.dart';

void modifierIdee(BuildContext context, Idee idee) async {
  var onPeutNaviguer =
      idee.estVide() ? true : await verifAvantNavigation(context);
  if (onPeutNaviguer) {
    var idees = context.read<MesIdeesModel>();
    idees.ideeEnCours = idee;
    idees.ideeAvantModif = new Idee.clone(idees.getIdeeEnCours());
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IdeeEcran(),
      ),
    );
  }
}

void defautAction() {
  // Action par défaut : ne fait rien
}

void supprimerIdee(BuildContext context, Idee idee) {
  var idees = context.read<MesIdeesModel>();
  idees.remove(idee);
}

void dupliquerIdee(BuildContext context, Idee idee) {
  var idees = context.read<MesIdeesModel>();
  idees.dupliquerIdee(idee);
}

void nePeutPasDevenirIdeePrincipale(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text('Cette idée est déjà associée à au moins 1 idée principale'),
          content: Text('Pensez à la dupliquer !'),
        );
      });
}

void sauverIdee(BuildContext context) {
  var idees = context.read<MesIdeesModel>();
  idees.sauverIdeeEnCours();
}

void retour(BuildContext context) {
  Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
}

Future<bool> verifAvantNavigation(BuildContext context) async {
  var idees = context.read<MesIdeesModel>();
  var valeurRetour = false;

  if (idees.enCoursAChange()) {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Enregistrer les modifications ?'),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Annuler'),
                ),
                FlatButton(
                  onPressed: () {
                    valeurRetour = true;
                    Navigator.pop(context);
                  },
                  child: Text('Ignorer'),
                ),
                FlatButton(
                  onPressed: () {
                    valeurRetour = true;
                    sauverIdee(context);
                    Navigator.pop(context);
                  },
                  child: Text('Enregistrer'),
                )
              ]);
        });
  } else {
    valeurRetour = true;
  }
  return valeurRetour;
}

// Future<bool> verifAvantNavigation(BuildContext context,
//     [Function retour = retourHome]) async {
//   var idees = context.read<MesIdeesModel>();

//   if (idees.enCoursAChange()) {
//     return await showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//                   title: Text('Enregistrer les modifications ?'),
//                   actions: [
//                     FlatButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: Text('Annuler'),
//                     ),
//                     FlatButton(
//                       onPressed: () {
//                         retour(context);
//                       },
//                       child: Text('Ignorer'),
//                     ),
//                     FlatButton(
//                       onPressed: () {
//                         sauverIdee(context);
//                       },
//                       child: Text('Enregistrer'),
//                     )
//                   ]) ??
//               false;
//         });
//   } else {
//     retour(context);
//   }
//   return false;
// }
