// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardsList _$CardsListFromJson(Map<String, dynamic> json) => CardsList(
      cards: (json['cards'] as List<dynamic>)
          .map((e) => MyCard.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CardsListToJson(CardsList instance) => <String, dynamic>{
      'cards': instance.cards,
    };

MyCard _$CardFromJson(Map<String, dynamic> json) => MyCard(
      id: json['id'] as int,
      row: json['row'] as String,
      seq_num: json['seq_num'] as int,
      text: json['text'] as String,
    );

Map<String, dynamic> _$CardToJson(MyCard instance) => <String, dynamic>{
      'id': instance.id,
      'row': instance.row,
      'seq_num': instance.seq_num,
      'text': instance.text,
    };
