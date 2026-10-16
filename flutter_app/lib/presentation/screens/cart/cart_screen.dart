import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../l10n/app_localizations.dart';
import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/cart/cart_event.dart';
import '../../blocs/cart/cart_state.dart';

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

                      return ListTile(
                        title: Text(item.meal.name),
                        subtitle: Text(
                          '${item.quantity} × '
                          '${(item.unitPrice / 100).toStringAsFixed(2)} EGP',
                        ),
                        leading: IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            context.read<CartBloc>().add(
                              DecreaseQuantity(item.meal.id),
                            );
                          },
                        ),
                        trailing: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () {
                                context.read<CartBloc>().add(
                                  IncreaseQuantity(item.meal.id),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () {
                                context.read<CartBloc>().add(
                                  RemoveFromCart(item.meal.id),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    '${l10n.total}: '
                    '${(state.totalPrice / 100).toStringAsFixed(2)} EGP',
                    style: Theme.of(context).textTheme.titleLarge,
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
