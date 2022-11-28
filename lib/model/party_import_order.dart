class PartyImportOrder {
  String? name;
  String? address;
  String? phone;
  String? bank;
  String? atBank;
  String? authorizedPerson;
  String? position;
  int? noAuthorization;
  DateTime? dateAuthorization;

  PartyImportOrder(
      {this.name,
      this.address,
      this.phone,
      this.bank,
      this.atBank,
      this.authorizedPerson,
      this.position,
      this.noAuthorization,
      this.dateAuthorization});

  PartyImportOrder.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    bank = json['bank'];
    atBank = json['atBank'];
    authorizedPerson = json['authorizedPerson'];
    position = json['position'];
    noAuthorization = json['noAuthorization'];
    dateAuthorization = json['dateAuthorization'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['bank'] = this.bank;
    data['atBank'] = this.atBank;
    data['authorizedPerson'] = this.authorizedPerson;
    data['position'] = this.position;
    data['noAuthorization'] = this.noAuthorization;
    data['dateAuthorization'] = this.dateAuthorization;
    return data;
  }
}
