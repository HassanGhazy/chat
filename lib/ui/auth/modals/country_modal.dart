class CountryModal {
  String? id;
  String? name;
  List<dynamic>? cistis;
  CountryModal(this.id, this.name, this.cistis);
  CountryModal.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.cistis = map['cities'];
  }
}
