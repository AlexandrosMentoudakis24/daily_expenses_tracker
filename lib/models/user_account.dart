class UserAccount {
  UserAccount({
    required this.accountId,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.email,
    required this.balance,
    required this.createdAt,
  });

  final String accountId;
  final String firstName;
  final String lastName;
  final int age;
  final String email;
  double balance;
  final DateTime createdAt;

  void increaseBalance(double depositAmount) {
    balance += depositAmount;
  }

  void decreaseBalance(double withdrawAmount) {
    if (balance - withdrawAmount < 0.0) throw Error();

    balance -= withdrawAmount;
  }
}
