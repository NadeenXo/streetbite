import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection.dart';
import '../../../l10n/app_localizations.dart';
import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/cart/cart_event.dart';
import '../../blocs/cart/cart_state.dart';
import '../../blocs/orders/orders_cubit.dart';
import '../../widgets/cart/cart_item_tile.dart';
import '../orders/checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocListener<CartBloc, CartState>(
      listenWhen: (previous, current) =>
          previous.actionId != current.actionId &&
          current.lastAction == CartAction.emptied,
      listener: (context, state) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.cartEmpty)));
      },
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.cart)),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state.items.isEmpty) {
              return Center(child: Text(l10n.cartEmpty));
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final item = state.items[index];

                      return CartItemTile(
                        item: item,
                        onIncrease: () {
                          context.read<CartBloc>().add(
                            IncreaseQuantity(item.meal.id),
                          );
                        },
                        onDecrease: () {
                          context.read<CartBloc>().add(
                            DecreaseQuantity(item.meal.id),
                          );
                        },
                        onRemove: () {
                          context.read<CartBloc>().add(
                            RemoveFromCart(item.meal.id),
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '${l10n.total}: '
                        '${(state.totalPrice / 100).toStringAsFixed(2)} '
                        '${l10n.currencyEgp}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      FilledButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => MultiBlocProvider(
                                providers: [
                                  BlocProvider<CartBloc>.value(
                                    value: context.read<CartBloc>(),
                                  ),
                                  BlocProvider<OrdersCubit>(
                                    create: (_) => sl<OrdersCubit>(),
                                  ),
                                ],
                                child: const CheckoutScreen(),
                              ),
                            ),
                          );
                        },
                        child: Text(l10n.checkout),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
