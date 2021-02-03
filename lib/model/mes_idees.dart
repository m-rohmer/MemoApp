import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:memo_app/dto/idee.dart';
import 'package:memo_app/model/trieur.dart';

class MesIdeesModel extends ChangeNotifier {
  final List<Idee> _idees = [];
  Idee _ideeEnCours;
  Idee _ideeAvantModif;
  TrieurModel _trieur;

  UnmodifiableListView<Idee> get idees => UnmodifiableListView(_idees);
  TrieurModel get trieur => _trieur;
  Idee get ideeEnCours => _ideeEnCours;
  Idee get ideeAvantModif => _ideeAvantModif;

  set trieur(TrieurModel nouvTrieur) {
    _trieur = nouvTrieur;
    notifyListeners();
  }

  set ideeEnCours(Idee nouvIdee) {
    _ideeEnCours = nouvIdee;
    notifyListeners();
  }

  set ideeAvantModif(Idee ideeAvantModif) {
    _ideeAvantModif = ideeAvantModif;
    notifyListeners();
  }

  bool isEmpty() {
    return idees.isEmpty;
  }

  bool hasIdeeSecondaire() {
    return idees.any((idee) => !idee.estIdeePrincipale);
  }

  List<Idee> getIdees() {
    return idees;
  }

  Idee getIdeeEnCours() {
    return ideeEnCours;
  }

  Idee getIdeeAvantModif() {
    return ideeAvantModif;
  }

  List<Idee> getIdeesSecondaires() {
    return idees.where((idee) => !idee.estIdeePrincipale).toList();
  }

  List<Idee> getIdeesAssociees(Idee nouvIdee) {
    return idees
        .where((idee) => nouvIdee.associations.contains(idee.id))
        .toList();
  }

  void sauverIdeeEnCours() {
    if (_ideeEnCours.estVide()) {
      return;
    }
    int index = _idees.indexWhere((i) => _ideeEnCours.equals(i));
    if (index < 0) {
      _idees.add(_ideeEnCours);
    } else {
      _ideeEnCours.dateModif = DateTime.now();
      _idees[index] = _ideeEnCours;
    }
    _trieur.trierIdees(_idees);

    _ideeAvantModif = new Idee.clone(_ideeEnCours);
    notifyListeners();
  }

  void remove(Idee idee) {
    _idees.remove(idee);
    notifyListeners();
  }

  bool enCoursAChange() {
    // si on était sur la page principale
    if (_ideeAvantModif == null) return false;
    // si nouvelle idée
    return (_ideeAvantModif.estVide() &&
            // on vérifie que le titre ou le corps est au moins renseigné
            !_ideeEnCours.estVide()) ||
        // sinon on vérifie différence avant / après
        (!_ideeAvantModif.estVide() &&
            !_ideeAvantModif.estIdentique(_ideeEnCours));
  }

  void setTitreIdeeEnCours(String text) {
    _ideeEnCours.titre = text;
  }

  void setCorpsIdeeEnCours(String text) {
    _ideeEnCours.corps = text;
  }

  void setCategorieEnCours(String text) {
    _ideeEnCours.categorie = text;
  }

  bool peutDevenirIdeePrincipale(Idee ideeEnCours) {
    return !_idees.any((idee) => idee.associations.contains(ideeEnCours.id));
  }

  void dupliquerIdee(Idee idee) {
    _idees.add(new Idee.duplique(idee));
    notifyListeners();
  }

  List<String> getCategories() {
    var categories = idees.map((idee) => idee.categorie).toList();
    categories.add(_ideeEnCours.categorie);
    categories.removeWhere((cat) => cat.isEmpty);
    return categories.toSet().toList();
  }
}
