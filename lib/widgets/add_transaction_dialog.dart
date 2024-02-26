import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:intl/intl.dart';

class AddTransactionDialog extends StatefulWidget {
  final List<String> options;
  final Function(ExpenseModel) onAddTransaction;

  const AddTransactionDialog({Key? key, required this.options, required this.onAddTransaction}) : super(key: key);

  @override
  State<AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  final TextEditingController itemController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  DateTime? pickedDate;
  late String selectedOption; 

  @override
  void initState() {
    super.initState();
    selectedOption = widget.options[0]; 
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Padding(
        padding: EdgeInsets.only(left: 1.6),
        child: Text("ADD TRANSACTION"),
      ),
      actions: [
        TextButton(
          onPressed: () {
            final expense = ExpenseModel(
              item: itemController.text,
              amount: int.parse(amountController.text),
              isIncome: selectedOption == "income", 
              date: pickedDate!,
            );
            widget.onAddTransaction(expense);
            itemController.clear();
            amountController.clear();
            dateController.clear();
            Navigator.pop(context);
          },
          child: const Text(
            "ADD",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "CANCEL",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ],
      content: SizedBox(
        height: 340,
        width: 400,
        child: Column(
          children: [
            TextField(
              controller: itemController,
              decoration: const InputDecoration(
                hintText: "Enter the Item",
                hintStyle: TextStyle(color: Colors.blueGrey),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Enter the Amount",
                hintStyle: TextStyle(color: Colors.blueGrey),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 18),
            Align(
              alignment: Alignment.centerLeft,
              child: TextField(
                onTap: () async {
                  pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  String date = DateFormat.yMMMMd().format(pickedDate!);
                  dateController.text = date;
                  setState(() {});
                },
                controller: dateController,
                decoration: const InputDecoration(
                  labelText: "DATE",
                  hintStyle: TextStyle(color: Colors.blueGrey),
                  filled: true,
                  prefixIcon: Icon(Icons.calendar_today),
                  prefixIconColor: Colors.blue,
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                ),
                readOnly: true,
              ),
            ),
            const SizedBox(height: 15),
            RadioMenuButton(
              value: widget.options[0],
              groupValue: selectedOption, 
              onChanged: (value) {
                setState(() {
                  selectedOption = value.toString(); 
                });
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  "Expense",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.4),
                ),
              ),
            ),
            RadioMenuButton(
              value: widget.options[1],
              groupValue: selectedOption, 
              onChanged: (value) {
                setState(() {
                  selectedOption = value.toString(); 
                });
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  "Income",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
