// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Global_model _$Global_modelFromJson(Map<String, dynamic> json) {
  return Global_model()
    ..NewConfirmed = json['NewConfirmed'] as num
    ..TotalConfirmed = json['TotalConfirmed'] as num
    ..NewDeaths = json['NewDeaths'] as num
    ..TotalDeaths = json['TotalDeaths'] as num
    ..NewRecovered = json['NewRecovered'] as num
    ..TotalRecovered = json['TotalRecovered'] as num;
}

Map<String, dynamic> _$Global_modelToJson(Global_model instance) =>
    <String, dynamic>{
      'NewConfirmed': instance.NewConfirmed,
      'TotalConfirmed': instance.TotalConfirmed,
      'NewDeaths': instance.NewDeaths,
      'TotalDeaths': instance.TotalDeaths,
      'NewRecovered': instance.NewRecovered,
      'TotalRecovered': instance.TotalRecovered
    };
