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

  @action
  getBankCards() async {
    bankCardsFuture = ObservableFuture(_bankCardRepository.getBankCards());
    await bankCardsFuture;
  }

  @observable
  @readonly
  BankCardEntity? bankCard;

  @action
  setBankId(String? value) => bankCard = bankCard?.copyWith(bankId: value);

  @action
  setSurnameName(String? value) => bankCard = bankCard?.copyWith(surnameName: value);

  @action
  setCardNumber(String? value) => bankCard = bankCard?.copyWith(cardNumber: value);

  @action
  setExpirationDate(String? value) => bankCard = bankCard?.copyWith(expirationDate: value);

  @computed
  bool get isValid =>
      bankCard != null &&
      bankCard!.bankId.isNotEmpty &&
      bankCard!.surnameName.isNotEmpty &&
      bankCard!.cardNumber.isNotEmpty &&
      bankCard!.expirationDate.isNotEmpty;

  @action
  saveCard() {
    if (bankCard != null) {
      bankCard = bankCard?.copyWith(id: BankCardEntity.generateId());
      _bankCardRepository.saveBankCard(bankCard!);
    }
  }

  @action
  removeCard(BankCardEntity bankCardEntity) async => await _bankCardRepository.removeBankCard(bankCardEntity.id);
}
