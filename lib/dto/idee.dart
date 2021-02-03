import 'package:uuid/uuid.dart';

class Idee {
  Uuid id;
  String titre;
  String corps;
  DateTime dateModif;
  bool estIdeePrincipale = false;
  Etat etat = Etat.enRedaction;
  String categorie;
  List<String> etiquettes = [];
  List<Uuid> associations = [];

  Idee()
      : id = Uuid(),
        dateModif = DateTime.now(),
        titre = "",
        corps = "",
        categorie = '';

  Idee.clone(Idee idee)
      : this.id = idee.id,
        this.titre = idee.titre,
        this.corps = idee.corps,
        this.dateModif = idee.dateModif,
        this.estIdeePrincipale = idee.estIdeePrincipale,
        this.etat = idee.etat,
        this.categorie = idee.categorie,
        this.etiquettes = idee.etiquettes,
        this.associations = idee.associations;

  Idee.duplique(Idee idee)
      : this.id = Uuid(),
        this.titre = idee.titre + ' - copie',
        this.corps = idee.corps,
        this.dateModif = DateTime.now(),
        this.estIdeePrincipale = idee.estIdeePrincipale,
        this.etat = idee.etat,
        this.categorie = idee.categorie,
        this.etiquettes = idee.etiquettes;

  void clone(Idee idee) {
    this.id = idee.id;
    this.titre = idee.titre;
    this.corps = idee.corps;
    this.dateModif = idee.dateModif;
    this.estIdeePrincipale = idee.estIdeePrincipale;
    this.etat = idee.etat;
    this.categorie = idee.categorie;
    this.etiquettes = idee.etiquettes;
    this.associations = idee.associations;
  }

  bool estIdentique(Idee idee) {
    return this.id == idee.id &&
        this.titre == idee.titre &&
        this.corps == idee.corps &&
        this.estIdeePrincipale == idee.estIdeePrincipale &&
        this.etat == idee.etat &&
        this.categorie == idee.categorie &&
        this.etiquettes == idee.etiquettes &&
        this.associations == idee.associations;
  }

  bool equals(Idee idee) {
    return this.id == idee.id;
  }

  bool estVide() {
    return titre.isEmpty && corps.isEmpty && associations.isEmpty;
  }
}

enum Etat { enRedaction, enCoursUtilisation, archive, supprime }
