import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spending_calculator/models/Transactions.dart';
import 'package:spending_calculator/widgets/charts.dart';
import 'package:spending_calculator/widgets/new_transaction.dart';
import 'package:spending_calculator/widgets/transaction_list.dart';

void main() {
  // These first 2 lines to lock orientation in verticale mode
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  //This line is not in it's best location but it's here to detect in which orientation i am in
  //to display based on it
  //MediaQuery.of(context).orientation

  //this line is used to padding more when soft keyboard is used and cover the widget
  //MediaQuery.of(context).viewInsets.bottom +10;

  //to check which platform the code is running on it
  //Platform.isIOS;
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
    final appBar = AppBar(
      //declared like that so i can access hights
      title: Text("Spending Expenses"),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => startNewTransactionWidget(context),
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height) *
                  0.3,
              //This is hot get status bar height//*MediaQuery.of(context).padding.top,
              child: Charts(thisWeekList)),
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
