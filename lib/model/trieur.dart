import 'package:flutter/material.dart';
import 'package:memo_app/dto/idee.dart';
import 'package:memo_app/dto/tri.dart';

class TrieurModel extends ChangeNotifier {
  final Tri _tri = new Tri();

  Tri get tri => _tri;

  Tri getTri() {
    return tri;
  }

  void setTriTitre(bool tri) {
    _tri.triTitre = tri;
    notifyListeners();
  }

  void trierIdees(List<Idee> idees) {
    if (_tri.triTitre) idees.sort((a, b) => a.titre.compareTo(b.titre));
    idees.sort((a, b) => b.dateModif.compareTo(a.dateModif));
  }
}
