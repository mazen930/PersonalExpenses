import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/Transactions.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> transactionList;
  final Function deleteItem;

  TransactionList(this.transactionList, this.deleteItem);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height *
            0.6, //to calculate height dynamicly
        child: transactionList.isEmpty
            ? Column(
                children: [
                  Text(
                    " No thing add yet",
                    style: Theme.of(context).textTheme.title,
                  ),
                  Container(
                      margin: EdgeInsets.all(10),
                      height: 200,
                      child: Image.asset(
                        "assets/images/waiting.png",
                        fit: BoxFit.cover,
                      ))
                ],
              )
            : ListView.builder(
                //instead of custom we can use List tile
                itemBuilder: (context, index) {
                  return Card(
                      child: Row(
                    children: [
                      Container(
                        child: Text(
                          '\$ ${transactionList[index].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2,
                                style: BorderStyle.solid)),
                        padding: EdgeInsets.all(5),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            transactionList[index].title,
                            style: Theme.of(context)
                                .textTheme
                                .title, //reference to text style used
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            DateFormat.yMMMd()
                                .format(transactionList[index].purchasedTime),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                      Spacer(
                        //this widget used to customize space between widget and keep that it doesn't take pixels out of range
                        flex: 3,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).errorColor,
                        ),
                        onPressed: () => deleteItem(
                            transactionList[index].id), //as it need parameter
                      ),
                    ],
                  ));
                },
                itemCount: transactionList.length,
              ));
  }
}
