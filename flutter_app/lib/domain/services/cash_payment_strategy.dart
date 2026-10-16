import 'payment_strategy.dart';

class CashPaymentStrategy implements PaymentStrategy {
  @override
  Future<bool> pay(int amountInPiastres) async {
    return amountInPiastres > 0;
  }
}
