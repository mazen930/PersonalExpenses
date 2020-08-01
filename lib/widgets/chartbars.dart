import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChartsBars extends StatelessWidget {
  final String label;
  final double amount, amountPercentage;

  ChartsBars(this.label, this.amount, this.amountPercentage);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      //using this widget to control max width and height available for this widget
      builder: (context, constrains) {
        return Column(
          children: [
            Container(
              height: 20,
              //to make the height is same in all column when text shrink
              child: FittedBox(
                //this widget try to fix
                child: Text('\$${amount.toStringAsFixed(0)}'),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              height: constrains.maxHeight * 0.7,
              //using constrains to calculate height
              width: 10,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        //color of border
                        color: Color.fromRGBO(220, 220, 220, 1),
                        //color of container itself
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  FractionallySizedBox(
                    heightFactor: amountPercentage,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(label)
          ],
        );
      },
    );
  }
}
