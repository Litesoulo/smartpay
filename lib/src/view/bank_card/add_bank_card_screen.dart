import 'package:auto_route/auto_route.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobx/mobx.dart';

import '../../../generated/strings.g.dart';
import '../../common/constant/app_constants.dart';
import '../../common/extensions/extensions.dart';
import '../../common/widget/space.dart';
import '../../model/entity/bank_entity.dart';
import '../../sl/sl.dart';
import '../../view_model/bank_card/bank_card_store.dart';
import '../../view_model/bank_card/bank_store.dart';

@RoutePage()
class AddBankCardScreen extends StatefulWidget {
  const AddBankCardScreen({
    super.key,
  });

  @override
  State<AddBankCardScreen> createState() => _AddBankCardScreenState();
}

class _AddBankCardScreenState extends State<AddBankCardScreen> {
  @override
  void dispose() {
    sl<BankCardStore>().dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.t.addCard.addCard,
          style: context.textTheme.titleLarge,
        ),
      ),
      body: Observer(builder: (context) {
        final banksFuture = sl<BankStore>().banksFuture;

        if (banksFuture.status == FutureStatus.pending) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final cardNumberMask = MaskTextInputFormatter(
          mask: '#### #### #### ####',
          filter: {"#": RegExp(r'[0-9]')},
          type: MaskAutoCompletionType.lazy,
        );
        final expirationDateMask = MaskTextInputFormatter(
          mask: '##/##',
          filter: {"#": RegExp(r'[0-9]')},
          type: MaskAutoCompletionType.lazy,
        );

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...[
                BankSelector(
                  banks: banksFuture.value ?? [],
                ),
                TextFormField(
                  onChanged: sl<BankCardStore>().setCardNumber,
                  keyboardType: const TextInputType.numberWithOptions(decimal: false, signed: true),
                  inputFormatters: [
                    cardNumberMask,
                  ],
                  decoration: InputDecoration(
                    labelText: context.t.addCard.cardNumber,
                    labelStyle: context.textTheme.labelMedium,
                  ),
                ),
                TextFormField(
                  onChanged: sl<BankCardStore>().setExpirationDate,
                  keyboardType: const TextInputType.numberWithOptions(decimal: false, signed: true),
                  inputFormatters: [
                    expirationDateMask,
                  ],
                  decoration: InputDecoration(
                    labelText: context.t.addCard.expirationDate,
                    labelStyle: context.textTheme.labelMedium,
                  ),
                ),
                TextFormField(
                  onChanged: sl<BankCardStore>().setSurnameName,
                  inputFormatters: [
                    TextInputFormatter.withFunction(
                      (oldValue, newValue) => newValue.copyWith(
                        text: newValue.text.toUpperCase(),
                      ),
                    ),
                  ],
                  decoration: InputDecoration(
                    labelText: context.t.addCard.surnameName,
                    labelStyle: context.textTheme.labelMedium,
                  ),
                ),
                Space.v10,
                FilledButton(
                  onPressed: () {
                    if (sl<BankCardStore>().isValid) {
                      sl<BankCardStore>().saveCard();
                      context.maybePop();
                    }
                  },
                  child: Text(
                    context.t.addCard.add,
                  ),
                ),
              ].expand(
                (e) => [
                  e,
                  Space.v10,
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}

class BankSelector extends StatelessWidget {
  final List<BankEntity> banks;

  const BankSelector({
    super.key,
    required this.banks,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<BankEntity?>(
      value: sl<BankStore>().getBankById(sl<BankCardStore>().bankCard.bankId),
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: AppConstants.padding / 2),
        label: Space.empty,
      ),
      hint: Text(
        context.t.addCard.selectBank,
      ),
      items: banks
          .map((bank) => DropdownMenuItem<BankEntity>(
                value: bank,
                child: Text(bank.name),
              ))
          .toList(),
      onChanged: (bank) => sl<BankCardStore>().setBankId(bank?.id),
    );
  }
}
