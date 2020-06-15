class GetCountry{
  int countryID;
  String countryTen;

  GetCountry({this.countryID,this.countryTen});

  factory GetCountry.fromJson(Map<String, dynamic> item) {
    return GetCountry(
      countryID: item['ID'],
      countryTen: item['ten'],
    );
  }

  Map<String, dynamic> toJson() => {
    "ID": countryID,
    "ten": countryTen,
  };

}