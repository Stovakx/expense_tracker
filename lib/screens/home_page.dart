import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/widgets/item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

//listy bych mohl mít v utils složce
List<String> options = [
  "expense",
  "income",
];

List items = [
  ExpenseModel(
      item: "computer", amount: 23423, date: DateTime.now(), isIncome: true)
];

class _HomePageState extends State<HomePage> {
  final itemController = TextEditingController();
  final amountController = TextEditingController();
  final dateController = TextEditingController();
  String currentOption = options[0];
  DateTime? pickedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return SizedBox(
                  height: 400,
                  child: AlertDialog(
                    title: const Text('Add Transaction'),
                    actions: [
                      TextButton(onPressed: () {}, child: const Text("ADD")),
                      TextButton(onPressed: () {}, child: const Text("CANCEL"))
                    ],
                    content: SizedBox(
                      height: 400,
                      width: 350,
                      child: Column(
                        children: [
                          TextField(
                            controller: itemController,
                            decoration: const InputDecoration(
                                hintText: "Enter the Item",
                                enabledBorder: OutlineInputBorder()),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: amountController,
                            decoration: const InputDecoration(
                                hintText: "Enter the Amount",
                                enabledBorder: OutlineInputBorder()),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            onTap: () async {
                              pickedDate = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                  initialDate: DateTime.now());
                              String convertedDate =
                                  DateFormat.yMMMMd().format(pickedDate!);
                              dateController.text = convertedDate;
                              setState(() {});
                            },
                            controller: dateController,
                            readOnly: true,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.calendar_today),
                                prefixIconColor: Colors.blue,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue))),
                          ),
                          RadioMenuButton(
                              value: options[0],
                              groupValue: currentOption,
                              onChanged: (expense) {
                                currentOption = expense.toString();
                              },
                              child: const Text("Expense")),
                          RadioMenuButton(
                              value: options[1],
                              groupValue: currentOption,
                              onChanged: (income) {
                                currentOption = income.toString();
                              },
                              child: const Text("income"))
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 6,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return const Item();
              },
            ))
          ],
        ),
      )),
    );
  }
}
