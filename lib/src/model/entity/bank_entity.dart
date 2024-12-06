import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../common/utils/helper_functions.dart';

part '../../../generated/src/model/entity/bank_entity.g.dart';

@JsonSerializable()
class BankEntity extends Equatable {
  final String id;
  final String nameEn;
  final String nameTk;
  final String nameRu;

  const BankEntity({
    required this.id,
    this.nameEn = '',
    this.nameTk = '',
    this.nameRu = '',
  });

  factory BankEntity.fromJson(Map<String, dynamic> json) => _$BankEntityFromJson(json);
  Map<String, dynamic> toJson() => _$BankEntityToJson(this);

  @override
  List<Object?> get props => [
        id,
        nameEn,
        nameTk,
        nameRu,
      ];

  String get name => getLocalizedText(
        en: nameEn,
        ru: nameRu,
        tk: nameTk,
      );
}
