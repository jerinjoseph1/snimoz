import 'package:snimoz/constants/keys.dart';

class TransactionModel {
  int id;
  double amount;
  String date;

  TransactionModel({
    this.id,
    this.amount,
    this.date,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> jsonData) =>
      TransactionModel(
        id: jsonData[TRANSACTION_ID],
        amount: jsonData[TRANSACTION_AMOUNT],
        date: jsonData[TRANSACTION_DATE],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonData = Map();
    jsonData[TRANSACTION_ID] = this.id;
    jsonData[TRANSACTION_AMOUNT] = this.amount;
    jsonData[TRANSACTION_DATE] = this.date;
    return jsonData;
  }
}
