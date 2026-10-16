import 'payment_strategy.dart';

class DemoCardPaymentStrategy implements PaymentStrategy {
  @override
  Future<bool> pay(int amountInPiastres) async {
    return amountInPiastres > 0;
  }
}
