import 'package:json_annotation/json_annotation.dart';

part 'card_model.g.dart';

@JsonSerializable()
class CardsList {
  List<MyCard> cards;

  CardsList({required this.cards});

  factory CardsList.fromJson(Map<String, dynamic> json) =>
      _$CardsListFromJson(json);
  Map<String, dynamic> toJson() => _$CardsListToJson(this);
}

@JsonSerializable()
class MyCard {
  int id;
  String row;
  int seq_num;
  String text;

  MyCard({required this.id, required this.row, required this.seq_num, required this.text});

  factory MyCard.fromJson(Map<String, dynamic> json) =>
      _$CardFromJson(json);
  Map<String, dynamic> toJson() => _$CardToJson(this);
}