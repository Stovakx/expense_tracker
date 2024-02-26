import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  const Item({Key? key, }) : super(key: key);
  //final String imageName;

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
              "images/expense.png",
              height: 40,
            ),
          ),
          const SizedBox(width: 10,),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Data",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 2),
              Text(
                "Date",
                style: TextStyle(color: Colors.blueGrey),
              )
            ],
          ),
          Text("\$30", style: TextStyle(fontSize: 21, color: Colors.green),)
        ]),
      ),
    );
  }
}
