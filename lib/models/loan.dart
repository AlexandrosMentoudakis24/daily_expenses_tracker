import 'package:daily_expense_tracker/models/user.dart';

enum LoanType {
  borrowed,
  lent,
}

enum LoanState {
  pending,
  completed,
}

class LoanAction {
  LoanAction({
    required this.loanActionId,
    required this.creatorId,
    required this.associatedAmmount,
  });

  final String loanActionId;
  final String creatorId;
  double associatedAmmount;
}

class Loan {
  Loan({
    required this.loanId,
    required this.associatedUser,
    required this.loanType,
    required this.associatedAmmount,
    required this.reason,
    required this.loanState,
    required this.loanActions,
  });

  final String loanId;
  final User associatedUser;
  final String reason;
  final LoanType loanType;
  double associatedAmmount;
  LoanState loanState;
  List<LoanAction> loanActions;

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
    loanState = LoanState.completed;
  }
}
