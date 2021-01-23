import 'package:flutter/material.dart';
import 'package:pprice_ui/reuse_widgets/custom_app_bar.dart';
import 'package:pprice_ui/reuse_widgets/custom_list_tile.dart';

class GiaDoiThu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFE7ECEF),
        appBar: CustomAppBar(
          tenSP: 'Áo sơ mi',
          giaNiemYet: '500.000 VNĐ',
          sKU: 'ABZ982',
          giaGoc: '400.000 VNĐ',
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              height: 65,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextField(
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        decoration: InputDecoration(
                          hintText: 'URL...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  RaisedButton(
                    child: Text(
                      'Thêm',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {},
                    color: Color(0xFF274C77),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15, left: 15, bottom: 10),
              child: Text('Cập nhật vào 5 phút trước'),
            ),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: [
                  CompetitorPriceTile(
                    competitorName: 'Amazone.com',
                    price: '475.000 VNĐ',
                    percentDiff: '-5%',
                  ),
                  CompetitorPriceTile(
                    competitorName: 'Amazone.com',
                    price: '490.000 VNĐ',
                    percentDiff: '-2%',
                  ),
                  CompetitorPriceTile(
                    competitorName: 'Amazone.com',
                    price: '500.000 VNĐ',
                    percentDiff: '+0%',
                  ),
                  CompetitorPriceTile(
                    competitorName: 'Amazone.com',
                    price: '510.000 VNĐ',
                    percentDiff: '+2%',
                  ),
                  CompetitorPriceTile(
                    competitorName: 'Amazone.com',
                    price: '525.000 VNĐ',
                    percentDiff: '+5%',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
