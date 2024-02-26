
class ExpenseModel{
  final String item;
  final int amount;
  final DateTime date;
  final bool isIncome;

  ExpenseModel({
    required this.item,
    required this.amount,
    required this.date,
    required this.isIncome,
  });
}