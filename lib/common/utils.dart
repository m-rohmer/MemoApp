String miseEnFormeText(String text) {
  String retour = text.split('\n').first;
  return retour.length > 100 ? retour.substring(0, 100) + '...' : retour;
}
