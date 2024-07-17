import 'package:daily_expense_tracker/models/user_account.dart';

enum ExchangeType {
  lend,
  borrow,
}

enum ExchangeState {
  pending,
  completed,
}

class ExchangeAction {
  ExchangeAction({
    required this.exchangeActionId,
    required this.creatorId,
    required this.associatedAmmount,
  });

  final String exchangeActionId;
  final String creatorId;
  double associatedAmmount;
}

class Exchange {
  Exchange({
    required this.loanId,
    required this.associatedUserAccount,
    required this.exchangeType,
    required this.associatedAmmount,
    required this.description,
    required this.exchangeState,
    required this.exchangeActions,
  });

  final String loanId;
  final UserAccount associatedUserAccount;
  final String description;
  final ExchangeType exchangeType;
  double associatedAmmount;
  ExchangeState exchangeState;
  List<ExchangeAction> exchangeActions;

  void payLoan(double paidAmmount) {
    if (associatedAmmount > paidAmmount) throw "Too much money!";
    if (paidAmmount <= 0.5) throw "Invalid ammount!";

    associatedAmmount -= paidAmmount;
  }

  void addMoreLoanedMoney(double newAmmount) {
    if (newAmmount <= 0.5) throw "Invalid ammount!";

    associatedAmmount += newAmmount;
  }

  void completeLoan() {
    exchangeState = ExchangeState.completed;
  }
}
