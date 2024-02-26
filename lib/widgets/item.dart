import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Item extends StatelessWidget {
  final ExpenseModel expenseModel;
  const Item({
    Key? key, required this.imageName, required this.expenseModel,
  }) : super(key: key);
  final String imageName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.all(9),
        decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(blurRadius: 4.0)],
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Row(children: [
          SizedBox(
            height: 35,
            width: 35,
            child: Image.asset(
              "images/$imageName",
              height: 40,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                expenseModel.item.toString(),
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 2),
              Text(
                DateFormat.yMMMMd().format(expenseModel.date),
                style: const TextStyle(color: Colors.blueGrey),
              )
            ],
          ),
          const Spacer(),
          Text(
            "\$${expenseModel.amount}",
            style: TextStyle(
                fontSize: 22, color:expenseModel.isIncome ? Colors.green: Colors.red, fontWeight: FontWeight.bold),
          )
        ]),
      ),
    );
  }
}
