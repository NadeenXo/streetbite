import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/services/cash_payment_strategy.dart';
import '../../../domain/services/demo_card_payment_strategy.dart';
import '../../../domain/services/payment_strategy.dart';
import '../../../l10n/app_localizations.dart';
import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/cart/cart_event.dart';
import '../../blocs/cart/cart_state.dart';
import '../../blocs/orders/orders_cubit.dart';
import '../../blocs/orders/orders_state.dart';

enum CheckoutPaymentMethod { cash, demoCard }

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  CheckoutPaymentMethod selectedMethod = CheckoutPaymentMethod.cash;

  void _placeOrder() {
    final user = FirebaseAuth.instance.currentUser;
    final cart = context.read<CartBloc>().state;
    if (user == null || cart.items.isEmpty) return;

    final PaymentStrategy strategy =
        selectedMethod == CheckoutPaymentMethod.cash
        ? CashPaymentStrategy()
        : DemoCardPaymentStrategy();

    context.read<OrdersCubit>().placeOrder(
      userId: user.uid,
      items: cart.items,
      paymentStrategy: strategy,
      paymentMethod: selectedMethod == CheckoutPaymentMethod.cash
          ? 'cash'
          : 'demo_card',
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocConsumer<OrdersCubit, OrdersState>(
      listener: (context, state) {
        if (state.orderPlaced) {
          context.read<CartBloc>().add(const ClearCart());
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(l10n.orderSuccess)));
          Navigator.of(context).popUntil((route) => route.isFirst);
        } else if (state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(l10n.orderError)));
        }
      },
      builder: (context, ordersState) {
        return Scaffold(
          appBar: AppBar(title: Text(l10n.checkout)),
          body: BlocBuilder<CartBloc, CartState>(
            builder: (context, cartState) {
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text(
                    l10n.orderSummary,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  for (final item in cartState.items)
                    ListTile(
                      title: Text(item.meal.name),
                      subtitle: Text(
                        '${item.quantity} × '
                        '${(item.unitPrice / 100).toStringAsFixed(2)} '
                        '${l10n.currencyEgp}',
                      ),
                    ),
                  const Divider(),
                  Text(
                    '${l10n.total}: '
                    '${(cartState.totalPrice / 100).toStringAsFixed(2)} '
                    '${l10n.currencyEgp}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    l10n.paymentMethod,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  RadioListTile<CheckoutPaymentMethod>(
                    title: Text(l10n.cashOnDelivery),
                    value: CheckoutPaymentMethod.cash,
                    // ignore: deprecated_member_use
                    groupValue: selectedMethod,
                    // ignore: deprecated_member_use
                    onChanged: ordersState.isSubmitting
                        ? null
                        : (value) {
                            if (value != null) {
                              setState(() => selectedMethod = value);
                            }
                          },
                  ),
                  RadioListTile<CheckoutPaymentMethod>(
                    title: Text(l10n.demoCard),
                    subtitle: Text(l10n.demoPaymentNotice),
                    value: CheckoutPaymentMethod.demoCard,
                    // ignore: deprecated_member_use
                    groupValue: selectedMethod,
                    // ignore: deprecated_member_use
                    onChanged: ordersState.isSubmitting
                        ? null
                        : (value) {
                            if (value != null) {
                              setState(() => selectedMethod = value);
                            }
                          },
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed:
                        ordersState.isSubmitting || cartState.items.isEmpty
                        ? null
                        : _placeOrder,
                    child: ordersState.isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(l10n.placeOrder),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
