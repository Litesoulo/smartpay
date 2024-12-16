import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../generated/strings.g.dart';
import '../../../main.dart';
import '../../common/constant/app_constants.dart';
import '../../common/extensions/extensions.dart';
import '../../common/widget/space.dart';
import '../../model/entity/payment_entity.dart';
import '../../sl/sl.dart';
import '../payment/store/payment_store.dart';

@RoutePage()
class ReceivePaymentScreen extends StatefulWidget {
  const ReceivePaymentScreen({super.key});

  @override
  State<ReceivePaymentScreen> createState() => _ReceivePaymentScreenState();
}

class _ReceivePaymentScreenState extends State<ReceivePaymentScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    sl<PaymentStore>().dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.padding),
        children: [
          ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width * 0.2),
              child: Observer(builder: (_) {
                final canEdit = sl<PaymentStore>().newPaymentFuture.value == null;
                return TextFormField(
                  controller: _controller,
                  enabled: canEdit,
                  keyboardType: const TextInputType.numberWithOptions(
                    signed: true,
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return null;
                    }
                    if (!RegExp(r'^\d*\.?\d{0,2}$').hasMatch(value)) {
                      return 'Please enter a valid amount with max 2 decimal places';
                    }
                    return null;
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: '10.00',
                    hintStyle: context.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface.withOpacity(0.5),
                    ),
                    suffixIcon: Container(
                      width: 60,
                      alignment: Alignment.center,
                      child: const Text(' TMT'),
                    ),
                  ),
                );
              }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width * 0.1),
              child: Observer(
                builder: (_) {
                  final newPaymentFuture = sl<PaymentStore>().newPaymentFuture;
                  final isPending = newPaymentFuture.status == FutureStatus.pending;
                  final newPayment = newPaymentFuture.value;
                  final isSuccess = newPayment != null;

                  if (isSuccess) {
                    return Container(
                      height: context.height * 0.4,
                      padding: const EdgeInsets.all(AppConstants.padding),
                      margin: EdgeInsets.only(top: context.height * 0.1),
                      alignment: Alignment.center,
                      child: QrImageView(
                        data: newPayment.id,
                      ),
                    );
                  }

                  return AnimatedSwitcher(
                    duration: AppConstants.defaultAnimationDuration,
                    child: isPending
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: FilledButton(
                                  onPressed: () {
                                    final amount = double.tryParse(_controller.text);

                                    if (amount == null) {
                                      ScaffoldMessenger.of(context).clearSnackBars();

                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            context.t.receive.enterAmount.replaceAll(':', ''),
                                          ),
                                        ),
                                      );
                                      return;
                                    }

                                    final payment = PaymentEntity(
                                      id: '',
                                      amount: amount,
                                      isSuccess: false,
                                      receiverId: businessId,
                                    );

                                    FocusScope.of(context).unfocus();

                                    sl<PaymentStore>().makePayment(payment);
                                  },
                                  child: Text(
                                    context.t.receive.receive,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  );
                },
              ),
            )
          ].expand(
            (e) => [
              e,
              Space.v10,
            ],
          ),
        ],
      ),
    );
  }
}
