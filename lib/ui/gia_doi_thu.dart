import 'package:flutter/material.dart';
import 'package:pprice_ui/reuse_widgets/custom_app_bar.dart';
import 'package:pprice_ui/reuse_widgets/custom_list_tile.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

class GiaDoiThu extends StatefulWidget {
  @override
  _GiaDoiThuState createState() => _GiaDoiThuState();
}

class _GiaDoiThuState extends State<GiaDoiThu> {
  static bool viewChart = false;

  var data1 = [
    CompetitorPrice("Amazone", 525000, 500000),
    CompetitorPrice("Tiki", 510000, 500000),
    CompetitorPrice("Sendo", 500000, 500000),
    CompetitorPrice("Lazada", 490000, 500000),
    CompetitorPrice("Shoppe", 475000, 500000),
  ];
  var data2 = [
    CompetitorPrice("Shoppe", 475000, 500000),
    CompetitorPrice("Lazada", 490000, 500000),
    CompetitorPrice("Sendo", 500000, 500000),
    CompetitorPrice("Tiki", 510000, 500000),
    CompetitorPrice("Amazone", 525000, 500000),
  ];

  @override
  Widget build(BuildContext context) {
    var series = [
      charts.Series(
        domainFn: (CompetitorPrice competitor, _) => competitor.name,
        measureFn: (CompetitorPrice competitor, _) => competitor.price,
        colorFn: (CompetitorPrice competitor, _) => competitor.color,
        id: 'Competitor Price',
        data: data1,
        labelAccessorFn: (CompetitorPrice competitor, _) =>
            '${competitor.name}: ${formartPrice(competitor.price)} VNĐ',
      )
    ];

    var barchart = charts.BarChart(
      series,
      vertical: false,
      barRendererDecorator: charts.BarLabelDecorator<String>(
        insideLabelStyleSpec: charts.TextStyleSpec(
          fontSize: 18,
          color: charts.MaterialPalette.white,
        ),
      ),
      domainAxis: charts.OrdinalAxisSpec(renderSpec: charts.NoneRenderSpec()),
    );

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Thấp nhất',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Shoppe',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '475.000 VNĐ',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Cao nhất',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Amazone',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '525.000 VNĐ',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text('Cập nhật vào 5 phút trước'),
                ),
                FlatButton(
                  onPressed: () {
                    if (viewChart == true)
                      viewChart = false;
                    else
                      viewChart = true;
                    setState(() {});
                  },
                  child: Icon(Icons.swap_horiz),
                  minWidth: 30,
                  shape: CircleBorder(),
                )
              ],
            ),
            Expanded(
              child: viewChart == false ? listView() : chart(barchart),
            ),
          ],
        ),
      ),
    );
  }

  Widget listView() {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 1));
      },
      child: ListView.separated(
        itemCount: data1.length,
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemBuilder: (context, index) {
          return SwipeActionCell(
            performsFirstActionWithFullSwipe: true,
            backgroundColor: Colors.transparent,
            key: ValueKey(data1[index]),
            trailingActions: [
              SwipeAction(
                content: Container(
                  padding: EdgeInsets.only(left: 10),
                  color: Colors.red,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                onTap: (handler) async {
                  await handler(true);
                },
              )
            ],
            child: CompetitorPriceTile(data1[index], 500000),
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 5),
      ),
    );
  }

  Widget chart(charts.BarChart chart) {
    return Container(
      padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      width: double.infinity,
      child: chart,
    );
  }
}

class CompetitorPrice {
  final String name;
  final int price;
  charts.Color color;

  CompetitorPrice(this.name, this.price, int giahientai) {
    if (price >= giahientai)
      this.color = charts.Color(r: 39, g: 174, b: 96);
    else
      this.color = charts.Color(r: 214, g: 48, b: 49);
  }
}

String formartPrice(int price) {
  var a = FlutterMoneyFormatter(
    amount: price.toDouble(),
    settings: MoneyFormatterSettings(
      thousandSeparator: '.',
      decimalSeparator: ',',
    ),
  ).output;
  return a.withoutFractionDigits.toString();
}
