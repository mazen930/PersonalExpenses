import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spending_calculator/models/Transactions.dart';
import 'package:spending_calculator/widgets/charts.dart';
import 'package:spending_calculator/widgets/new_transaction.dart';
import 'package:spending_calculator/widgets/transaction_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spending Expenses',
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amberAccent,
          fontFamily: "QuickSand",
          textTheme: ThemeData.light().textTheme.copyWith(
              //global text style used
              title: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                      title: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final List<Transactions> transactionList = [];

  void startNewTransactionWidget(BuildContext ctx) {
    showModalBottomSheet(
        //like pop up menu
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            child: NewUserTransaction(addTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void addTransaction(String title, double amount, DateTime purchasedTime) {
    setState(() {
      transactionList.add(new Transactions(
          id: DateTime.now().toString(),
          title: title,
          amount: amount,
          purchasedTime: purchasedTime));
    });
  }

  void deleteTransaction(String id) {
    setState(() {
      transactionList.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  List<Transactions> get thisWeekList {
    return transactionList.where((tx) {
      return tx.purchasedTime
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Spending Expenses"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => startNewTransactionWidget(context),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Charts(thisWeekList),
          Expanded(child: TransactionList(transactionList, deleteTransaction)),
          //new trans
          //trans list
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startNewTransactionWidget(context),
      ),
    );
  }
}
