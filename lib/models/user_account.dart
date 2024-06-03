class UserAccount {
  UserAccount({
    required this.accountId,
    required this.firstName,
    required this.lastName,
    required this.balance,
  });

  final String accountId;
  final String firstName;
  final String lastName;
  double balance;

  void increaseBalance(double depositAmount) {
    balance += depositAmount;
  }

  void decreaseBalance(double withdrawAmount) {
    if (balance - withdrawAmount < 0.0) throw Error();

    balance -= withdrawAmount;
  }
}
