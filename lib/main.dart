import 'package:flutter/material.dart';
import 'package:memo_app/model/trieur.dart';
import 'package:provider/provider.dart';

import 'model/mes_idees.dart';
import 'screens/premier_ecran.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TrieurModel(),
        ),
        // Puisque mes idées dépendent du trieur
        ChangeNotifierProxyProvider<TrieurModel, MesIdeesModel>(
            create: (context) => MesIdeesModel(),
            update: (context, trieur, mesidees) {
              mesidees.trieur = trieur;
              return mesidees;
            }),
      ],
      child: MaterialApp(
        title: 'Appli de création d\'idées',
        home: PremierEcran(),
      ),
    );
  }
}
