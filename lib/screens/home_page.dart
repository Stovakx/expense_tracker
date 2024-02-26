import 'package:expense_tracker/widgets/add_transaction_dialog.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/widgets/fund_condition.dart';
import 'package:expense_tracker/widgets/item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> options = ["expense", "income"];
  final List<ExpenseModel> expenses = [];
  final TextEditingController itemController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  int totalMoney = 0;
  int spentMoney = 0;
  int income = 0;
  DateTime? pickedDate;
  String currentOption = "expense";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: _showAddTransactionDialog,
        child: const Icon(Icons.add, size: 26),
      ),
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        centerTitle: true,
        backgroundColor: Colors.red.shade500,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFundCondition(type: "DEPOSIT", amount: "$totalMoney", icon: "blue"),
                _buildFundCondition(type: "EXPENSE", amount: "$spentMoney", icon: "orange"),
                _buildFundCondition(type: "INCOME", amount: "$income", icon: "grey"),
              ],
            ),
            const SizedBox(height: 14),
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _showDeleteConfirmationDialog(expenses[index]),
                    child: Item(
                      expense: expenses[index],
                      onDelete: () => _deleteExpense(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddTransactionDialog() {
    showDialog(
      context: context,
      builder: (context) => AddTransactionDialog(
        options: options,
        onAddTransaction: _addTransaction,
      ),
    );
  }

  void _addTransaction(ExpenseModel expense) {
    expenses.add(expense);
    if (expense.isIncome) {
      income += expense.amount;
      totalMoney += expense.amount;
    } else {
      spentMoney += expense.amount;
      totalMoney -= expense.amount;
    }
    setState(() {});
  }

  void _deleteExpense(int index) {
    final myExpense = expenses[index];
    if (myExpense.isIncome) {
      income -= myExpense.amount;
      totalMoney -= myExpense.amount;
    } else {
      spentMoney -= myExpense.amount;
      totalMoney += myExpense.amount;
    }
    expenses.remove(myExpense);
    setState(() {});
  }

  void _showDeleteConfirmationDialog(ExpenseModel expense) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Confirm to Delete the Item ?",
          style: TextStyle(fontSize: 19.0),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("CANCEL", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          TextButton(
            onPressed: () {
              _deleteExpense(expenses.indexOf(expense));
              Navigator.pop(context);
            },
            child: const Text("DELETE", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildFundCondition({required String type, required String amount, required String icon}) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: FundCondition(type: type, amount: amount, icon: icon),
    );
  }
}
