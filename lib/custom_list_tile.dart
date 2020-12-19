import 'package:flutter/material.dart';

class CompetitorPriceTile extends StatelessWidget {
  String competitorName;
  String price;
  String percentDiff; // TODO code lại tự tính ???

  CompetitorPriceTile({this.competitorName, this.price, this.percentDiff});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              competitorName,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            price,
            style: TextStyle(
                fontSize: 22,
                //color: Colors.red,
                color: Color(0xFF274C77),
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            width: 40,
            child: Text(
              percentDiff,
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
