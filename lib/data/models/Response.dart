class Country {
  final country;
  final newConfirmed;
  final totalConfirmed;
  final newDeaths;
  final totalDeaths;
  final newRecovered;
  final totalRecovered;

  Country(this.country, this.newConfirmed, this.totalConfirmed, this.newDeaths,
      this.totalDeaths, this.newRecovered, this.totalRecovered);

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      json['Country'] as String,
      json['NewConfirmed'] as int,
      json['TotalConfirmed'] as int,
      json['NewDeaths'] as int,
      json['TotalDeaths'] as int,
      json['NewRecovered'] as int,
      json['TotalRecovered'] as int,
    );
  }
}

class Global {
  final newConfirmed;
  final totalConfirmed;
  final newDeaths;
  final totalDeaths;
  final newRecovered;
  final totalRecovered;

  Global(this.newConfirmed, this.totalConfirmed, this.newDeaths,
      this.totalDeaths, this.newRecovered, this.totalRecovered);

  factory Global.fromJson(Map<String, dynamic> json) {
    return Global(
      json['NewConfirmed'] as int,
      json['TotalConfirmed'] as int,
      json['NewDeaths'] as int,
      json['TotalDeaths'] as int,
      json['NewRecovered'] as int,
      json['TotalRecovered'] as int,
    );
  }
}
