import 'package:json_annotation/json_annotation.dart';

part 'country_model.g.dart';

@JsonSerializable()
class Country_model {
    Country_model();

    String Country;
    String CountryCode;
    String Slug;
    num NewConfirmed;
    num TotalConfirmed;
    num NewDeaths;
    num TotalDeaths;
    num NewRecovered;
    num TotalRecovered;
    String Date;
    
    factory Country_model.fromJson(Map<String,dynamic> json) => _$Country_modelFromJson(json);
    Map<String, dynamic> toJson() => _$Country_modelToJson(this);
}
