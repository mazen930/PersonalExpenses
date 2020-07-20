import 'dart:ffi';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class NewUserTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewUserTransaction(this.addNewTransaction);

  NewUserTransactionState createState() => NewUserTransactionState();
}

class NewUserTransactionState extends State<NewUserTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime chosenDate;

  void showDatePickerFunction() {
    showDatePicker(
            context: context,
            firstDate: DateTime(2019),
            lastDate: DateTime.now(),
            initialDate: DateTime.now())
        .then((value) {
      if (value == null) return;
      setState(() {
        chosenDate = value;
      });
    });
  }

  void submitData() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);
    if (title.isEmpty || amount <= 0 || chosenDate == null) return;
    widget.addNewTransaction(title, amount,
        chosenDate); //widget is used to use function from the first class in stateful widget
    Navigator.of(context).pop(); //to close modal bottom sheet
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: "Title"),
            controller: titleController,
            onSubmitted: (_) => submitData(), //refers to un used input
          ),
          TextField(
            decoration: InputDecoration(labelText: "Amount"),
            controller: amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => submitData(),
          ),
          Container(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  //this widget is used so the wrapped widget can get as much space as it can take
                  child: Text(chosenDate == null
                      ? "No Date is chosen"
                      : DateFormat.yMd().format(chosenDate)),
                ),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  child: Text("Choose you date"),
                  onPressed: showDatePickerFunction,
                )
              ],
            ),
          ),
          RaisedButton(
            child: Text("Add Transaction"),
            textColor: Colors.white,
            color: Theme.of(context).primaryColor,
            onPressed: submitData,
          ),
        ],
      ),
    );
  }
}
