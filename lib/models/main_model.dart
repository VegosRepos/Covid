import 'package:json_annotation/json_annotation.dart';
import "global_model.dart";
import "country_model.dart";
part 'main_model.g.dart';

@JsonSerializable()
class Main_model {
    Main_model();

    Global_model Global;
    List<Country_model> Countries;
    
    factory Main_model.fromJson(Map<String,dynamic> json) => _$Main_modelFromJson(json);
    Map<String, dynamic> toJson() => _$Main_modelToJson(this);
}
