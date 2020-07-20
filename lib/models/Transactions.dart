import 'package:flutter/cupertino.dart';

class Transactions {
  String id, title;
  double amount;
  DateTime purchasedTime;

  Transactions(
      {@required this.id,
      @required this.title,
      @required this.amount,
      @required this.purchasedTime});
}
