import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spending_calculator/models/Transactions.dart';
import 'package:intl/intl.dart';
import 'package:spending_calculator/widgets/chartbars.dart';

class Charts extends StatelessWidget {
  final List<Transactions> currentTransactionList;

  Charts(this.currentTransactionList);

  List<Map<String, Object>> get groupedTransactionValue {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(
        days: index,
      ));
      double totalSum = 0;
      for (int i = 0; i < currentTransactionList.length; i++) {
        if (currentTransactionList[i].purchasedTime.day == weekDay.day &&
            currentTransactionList[i].purchasedTime.month == weekDay.month &&
            currentTransactionList[i].purchasedTime.year == weekDay.year) {
          totalSum += currentTransactionList[i].amount;
        }
      }
      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "amount": totalSum
      };
    });
  }

  double get totalSpending {
    return groupedTransactionValue.fold(0.0, (sum, element) {
      return sum += element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupedTransactionValue.map((day) {
          return Flexible(
            //this widget used to make it save only it's space
            fit: FlexFit.tight,
            child: ChartsBars(
                day['day'],
                day['amount'],
                totalSpending == 0
                    ? 0
                    : (day['amount'] as double) / totalSpending),
          );
        }).toList(),
      ),
      elevation: 6,
      margin: EdgeInsets.all(20),
    );
  }
}
