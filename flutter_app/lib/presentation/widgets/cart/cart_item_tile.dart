import 'package:flutter/material.dart';

import '../../../domain/entities/cart_item_entity.dart';
import '../../../l10n/app_localizations.dart';

class CartItemTile extends StatelessWidget {
  final CartItemEntity item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  const CartItemTile({
    super.key,
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.meal.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              '${(item.totalPrice / 100).toStringAsFixed(2)} '
              '${l10n.currencyEgp}',
            ),
            Row(
              children: [
                IconButton(
                  tooltip: l10n.decreaseQuantity,
                  onPressed: onDecrease,
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text('${item.quantity}'),
                IconButton(
                  tooltip: l10n.increaseQuantity,
                  onPressed: onIncrease,
                  icon: const Icon(Icons.add_circle_outline),
                ),
                const Spacer(),
                IconButton(
                  tooltip: l10n.remove,
                  onPressed: onRemove,
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
