import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'joke_model.g.dart';

@JsonSerializable()
class JokeModel extends Equatable {
  const JokeModel({
    required this.safe,
    this.category,
    this.delivery,
    this.id,
    this.lang,
    this.setup,
    this.type,
  });

  //Json Serializable
  factory JokeModel.fromJson(Map<String, dynamic> json) =>
      _$JokeModelFromJson(json);

  Map<String, dynamic> toJson() => _$JokeModelToJson(this);

  final String? category;
  final String? delivery;
  final int? id;
  final String? lang;
  final bool safe;
  final String? setup;
  final String? type;

  @override
  List<Object?> get props => [
    category,
    delivery,
    id,
    lang,
    safe,
    setup,
    type,
  ];
}