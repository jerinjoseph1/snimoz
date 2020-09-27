import 'package:flutter/cupertino.dart';
import 'package:snimoz/helpers/dbHelper.dart';
import 'package:snimoz/models/transaction_model.dart';

class WalletData extends ChangeNotifier {
  List<TransactionModel> _transactions = [];
  double _currentBalance = 0.0;

  set currentBalance(double currentBalance) {
    _currentBalance = currentBalance;
    notifyListeners();
  }

  set transactions(List<TransactionModel> transactions) {
    _transactions = transactions;
    notifyListeners();
  }

  double get currentBalance => _currentBalance;

  List<TransactionModel> get transactions => _transactions;

  Future<void> fetchTransactions() async {
    final dbHelper = DatabaseHelper.instance;
    final data = await dbHelper.queryAllTransactions();

    currentBalance = 0.0;

    if (data.isEmpty || data == null) return;

    transactions = data.map((e) => TransactionModel.fromJson(e)).toList();
    for (TransactionModel transaction in transactions) {
      currentBalance += transaction.amount;
    }
  }

  Future<void> addTransaction({double amount}) async {
    final dbHelper = DatabaseHelper.instance;
    TransactionModel transaction = TransactionModel();
    transaction.date = DateTime.now().toString();
    transaction.amount = amount;
    await dbHelper.addTransaction(transaction);
    await fetchTransactions();
  }
}
