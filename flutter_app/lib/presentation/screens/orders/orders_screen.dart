import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../l10n/app_localizations.dart';
import '../../blocs/orders/orders_cubit.dart';
import '../../blocs/orders/orders_state.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();

    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      context.read<OrdersCubit>().watchOrders(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.myOrders)),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null) {
            return Center(child: Text(l10n.orderError));
          }

          if (state.orders.isEmpty) {
            return Center(child: Text(l10n.noOrders));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.orders.length,
            itemBuilder: (context, index) {
              final order = state.orders[index];

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${l10n.orderNumber}: ${order.id}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${l10n.total}: '
                        '${(order.totalAmount / 100).toStringAsFixed(2)} '
                        '${l10n.currencyEgp}',
                      ),
                      Text(
                        '${l10n.paymentMethod}: '
                        '${order.paymentMethod == 'cash' ? l10n.cashOnDelivery : l10n.demoCard}',
                      ),
                      Text('${l10n.orderStatus}: ${order.status}'),
                      const Divider(),
                      for (final item in order.items)
                        Text('${item.meal.name} × ${item.quantity}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
