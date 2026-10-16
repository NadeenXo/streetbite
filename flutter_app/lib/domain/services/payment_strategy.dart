abstract interface class PaymentStrategy {
  Future<bool> pay(int amountInPiastres);
}
