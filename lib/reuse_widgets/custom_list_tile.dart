import 'package:flutter/material.dart';
import 'package:pprice_ui/ui/gia_doi_thu.dart';

class CompetitorPriceTile extends StatelessWidget {
  final CompetitorPrice competitorPrice;
  final int giahientai;
  double phantram;

  CompetitorPriceTile(this.competitorPrice, this.giahientai) {
    phantram = (giahientai / competitorPrice.price).toDouble();

    if (giahientai > competitorPrice.price)
      phantram = (phantram - 1) * 100;
    else
      phantram = (1 - phantram) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      margin: EdgeInsets.only(left: 10, right: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              competitorPrice.name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            formartPrice(competitorPrice.price) + ' VNĐ',
            style: TextStyle(
                fontSize: 22,
                color: Color(0xFF274C77),
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            width: 40,
            child: Text(
              phantram.toStringAsFixed(0) + '%',
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: giahientai > competitorPrice.price
                    ? Color(0xffD63031)
                    : Color(0xff27AE60),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
