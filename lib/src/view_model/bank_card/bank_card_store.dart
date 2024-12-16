import 'package:mobx/mobx.dart';

import '../../model/entity/bank_card_entity.dart';
import '../../model/repository/bank_card_repository.dart';

part '../../../generated/src/view_model/bank_card/bank_card_store.g.dart';

class BankCardStore = _BankCardStoreBase with _$BankCardStore;

abstract class _BankCardStoreBase with Store {
  final BankCardRepository _bankCardRepository;

  _BankCardStoreBase({
    required BankCardRepository bankCardRepository,
  }) : _bankCardRepository = bankCardRepository;

  @observable
  @readonly
  ObservableFuture<List<BankCardEntity>> bankCardsFuture = ObservableFuture.value([]);

  @computed
  List<BankCardEntity> get bankCards {
    final bankCardsList = bankCardsFuture.value ?? [];

    bankCardsList.sort(
      (a, b) =>
          a.dateAdd?.compareTo(
            b.dateAdd ?? DateTime(0),
          ) ??
          0,
    );

    return bankCardsList;
  }

  @action
  getBankCards() async {
    bankCardsFuture = ObservableFuture(_bankCardRepository.getBankCards());
    await bankCardsFuture;
  }

  @observable
  @readonly
  BankCardEntity bankCard = const BankCardEntity(id: '');

  @action
  setBankId(String? value) => bankCard = bankCard.copyWith(bankId: value);

  @action
  setSurnameName(String? value) => bankCard = bankCard.copyWith(surnameName: value);

  @action
  setCardNumber(String? value) => bankCard = bankCard.copyWith(cardNumber: value);

  @action
  setExpirationDate(String? value) => bankCard = bankCard.copyWith(expirationDate: value);

  @computed
  bool get isValid =>
      bankCard.bankId.isNotEmpty &&
      bankCard.surnameName.isNotEmpty &&
      bankCard.cardNumber.isNotEmpty &&
      bankCard.expirationDate.isNotEmpty;

  @action
  saveCard() async {
    bankCard = bankCard.copyWith(
      id: BankCardEntity.generateId(),
      dateAdd: DateTime.now(),
    );

    await _bankCardRepository.saveBankCard(bankCard);

    bankCard = const BankCardEntity(id: '');

    await getBankCards();
  }

  @action
  removeCard(BankCardEntity bankCardEntity) async {
    await _bankCardRepository.removeBankCard(bankCardEntity.id);
    await getBankCards();
  }

  dispose() async {
    bankCardsFuture = ObservableFuture.value([]);
    bankCard = const BankCardEntity(id: '');
    await getBankCards();
  }
}
