import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part '../../../generated/src/model/entity/bank_card_entity.g.dart';

@JsonSerializable()
class BankCardEntity extends Equatable {
  final String id;
  final String bankId;
  final String surnameName;
  final String cardNumber;
  final DateTime? expirationDate;

  const BankCardEntity({
    required this.id,
    this.bankId = '',
    this.surnameName = '',
    this.cardNumber = '',
    this.expirationDate,
  });

  factory BankCardEntity.fromJson(Map<String, dynamic> json) => _$BankCardEntityFromJson(json);
  Map<String, dynamic> toJson() => _$BankCardEntityToJson(this);

  @override
  List<Object?> get props => [
        id,
        bankId,
        surnameName,
        cardNumber,
        expirationDate,
      ];
}
