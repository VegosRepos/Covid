// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Main_model _$Main_modelFromJson(Map<String, dynamic> json) {
  return Main_model()
    ..Global = json['Global'] == null
        ? null
        : Global_model.fromJson(json['Global'] as Map<String, dynamic>)
    ..Countries = (json['Countries'] as List)
        ?.map((e) => e == null
            ? null
            : Country_model.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$Main_modelToJson(Main_model instance) =>
    <String, dynamic>{
      'Global': instance.Global,
      'Countries': instance.Countries
    };
