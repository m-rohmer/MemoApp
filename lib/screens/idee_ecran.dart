import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import 'package:memo_app/dto/idee.dart';
import 'package:memo_app/model/mes_idees.dart';
import 'package:memo_app/common/manipuler_idee.dart';
import 'package:memo_app/widgets/menu_gauche_widget.dart';
import 'package:memo_app/widgets/sous_ecran_widget.dart';

class IdeeEcran extends StatefulWidget {
  IdeeEcran() : super();

  @override
  _IdeeEcranState createState() => _IdeeEcranState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _IdeeEcranState extends State<IdeeEcran> {
  _IdeeEcranState();

  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final titreController = TextEditingController();
  final corpsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var idees = context.watch<MesIdeesModel>();
    Idee enCours = idees.getIdeeEnCours();

    _initControllers(enCours);
    return WillPopScope(
      onWillPop: () => verifAvantNavigation(context),
      child: Scaffold(
        drawer: MenuGauche(),
        appBar: AppBar(
          title: TextField(
            maxLengthEnforced: true,
            maxLength: 50,
            maxLines: 1,
            decoration: InputDecoration(
              labelText: 'Titre',
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            controller: titreController,
            onChanged: (text) {
              idees.setTitreIdeeEnCours(text);
            },
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Enregistrer'),
              onPressed: () {
                sauverIdee(context);
                retour(context);
              },
            )
          ],
        ),
        body: SlidingSheet(
          elevation: 8,
          cornerRadius: 16,
          snapSpec: const SnapSpec(
            // Enable snapping. This is true by default.
            snap: true,
            // Set custom snapping points.
            snappings: [0.1, 0.8, 1.0],
            // Define to what the snappings relate to. In this case,
            // the total available space that the sheet can expand to.
            positioning: SnapPositioning.relativeToAvailableSpace,
          ),
          // The body widget will be displayed under the SlidingSheet
          // and a parallax effect can be applied to it.
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: corpsController,
              decoration: InputDecoration(
                labelText: 'Description',
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
              minLines: 1,
              maxLines: null,
              onChanged: (text) {
                idees.setCorpsIdeeEnCours(text);
              },
            ),
          ),
          builder: (context, state) {
            // This is the content of the sheet that will get
            // scrolled, if the content is bigger than the available
            // height of the sheet.
            return enCours.estIdeePrincipale
                ? Container(
                    key: UniqueKey(),
                    height: 500,
                    child: SousEcran(),
                  )
                : Container();
          },
        ),
      ),
    );
  }

  void _initControllers(Idee idee) {
    titreController.text = idee.titre;
    corpsController.text = idee.corps;
  }
}
