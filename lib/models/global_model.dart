import 'package:json_annotation/json_annotation.dart';

part 'global_model.g.dart';

@JsonSerializable()
class Global_model {
    Global_model();

    num NewConfirmed;
    num TotalConfirmed;
    num NewDeaths;
    num TotalDeaths;
    num NewRecovered;
    num TotalRecovered;
    
    factory Global_model.fromJson(Map<String,dynamic> json) => _$Global_modelFromJson(json);
    Map<String, dynamic> toJson() => _$Global_modelToJson(this);
}
