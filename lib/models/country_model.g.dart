// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country_model _$Country_modelFromJson(Map<String, dynamic> json) {
  return Country_model()
    ..Country = json['Country'] as String
    ..CountryCode = json['CountryCode'] as String
    ..Slug = json['Slug'] as String
    ..NewConfirmed = json['NewConfirmed'] as num
    ..TotalConfirmed = json['TotalConfirmed'] as num
    ..NewDeaths = json['NewDeaths'] as num
    ..TotalDeaths = json['TotalDeaths'] as num
    ..NewRecovered = json['NewRecovered'] as num
    ..TotalRecovered = json['TotalRecovered'] as num
    ..Date = json['Date'] as String;
}

Map<String, dynamic> _$Country_modelToJson(Country_model instance) =>
    <String, dynamic>{
      'Country': instance.Country,
      'CountryCode': instance.CountryCode,
      'Slug': instance.Slug,
      'NewConfirmed': instance.NewConfirmed,
      'TotalConfirmed': instance.TotalConfirmed,
      'NewDeaths': instance.NewDeaths,
      'TotalDeaths': instance.TotalDeaths,
      'NewRecovered': instance.NewRecovered,
      'TotalRecovered': instance.TotalRecovered,
      'Date': instance.Date
    };
