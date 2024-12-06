import 'package:mobx/mobx.dart';

import 'package:collection/collection.dart';

import '../../model/entity/bank_entity.dart';
import '../../model/repository/bank_repository.dart';

part '../../../generated/src/view_model/bank_card/bank_store.g.dart';

class BankStore = _BankStoreBase with _$BankStore;

abstract class _BankStoreBase with Store {
  final BankRepository _bankRepository;

  _BankStoreBase({
    required BankRepository bankRepository,
  }) : _bankRepository = bankRepository;

  @observable
  @readonly
  ObservableFuture<List<BankEntity>> banksFuture = ObservableFuture.value([]);

  BankEntity? getBankById(String? id) {
    final banks = banksFuture.value ?? [];

    final bank = banks.firstWhereOrNull(
      (e) => e.id == id,
    );

    return bank;
  }

  @action
  getBanks() async {
    banksFuture = ObservableFuture(_bankRepository.getBanks());
    await banksFuture;
  }
}
