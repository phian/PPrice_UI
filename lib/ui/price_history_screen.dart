import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PriceHistoryScreen extends StatefulWidget {
  PriceHistoryScreen({Key key}) : super(key: key);

  @override
  _PriceHistoryScreenState createState() => _PriceHistoryScreenState();
}

class _PriceHistoryScreenState extends State<PriceHistoryScreen> {
  String _startDate, _endDate;
  DateTime _startDateDateTime, _endDateDateTime;
  List<Color> _gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  bool _isBarChart;

  @override
  void initState() {
    super.initState();

    _startDate = DateFormat("dd/MM/yyyy").format(DateTime.now());
    _endDate = DateFormat("dd/MM/yyyy").format(DateTime.now());
    _startDateDateTime = DateTime.now();
    _endDateDateTime = DateTime.now();
    _isBarChart = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE7ECEF),
      appBar: _priceHistoryScreenAppBar(),
      body: _priceHistoryScreenBody(),
    );
  }

  /// [App Bar]
  Widget _priceHistoryScreenAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Color(0xFF274C77),
      elevation: 0.0,
      title: Text(
        "Lịch sử giá",
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// [Body]
  Widget _priceHistoryScreenBody() {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20.0),
                alignment: Alignment.topCenter,
                child: Text(
                  "Áo sơ mi",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _startAndEndDateWidget(
                      title: "Từ ngày",
                      startDate: _startDate,
                      index: 0,
                    ),
                    _startAndEndDateWidget(
                      title: "Đến ngày",
                      endDate: _endDate,
                      index: 1,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 30.0),
                height: MediaQuery.of(context).size.height * 0.7,
                child: _isBarChart
                    ? ListView(
                        physics: AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        children: [
                          _priceHistoryMonthTitle(month: "Tháng 12 - 2020"),
                          _priceHistoryCard(
                            date: "10/12/2020",
                            time: "9:00 AM",
                            priceBeforeChange: "1.500.000",
                            priceAfterChange: "1.200.000",
                            percent: "8",
                            isDown: true,
                          ),
                        ],
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 20.0),
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.15,
                        ),
                        child: LineChart(
                          _priceHistoryLineChart(),
                        ),
                      ),
              ),
            ],
          ),
        ),
        _changeViewTypeButton(
          icon: _isBarChart ? Icons.insert_chart_outlined : Icons.list_alt,
        ),
      ],
    );
  }

  /// [Change view type button]
  Widget _changeViewTypeButton({IconData icon}) {
    return Container(
      alignment: Alignment.topRight,
      margin: EdgeInsets.only(top: 15.0),
      child: IconButton(
        onPressed: () {
          setState(() {
            _isBarChart = !_isBarChart;
          });
        },
        icon: Icon(
          icon,
          size: 30.0,
        ),
      ),
    );
  }

  /// [Show calendar to pick start or end date]
  void _showDatePicker({int index}) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: index == 0
          ? DateTime.now().subtract(
              Duration(days: 10000),
            )
          : DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(days: 10000),
      ),
    ).then((value) {
      if (value != null) {
        setState(() {
          if (index == 0) {
            _startDate = DateFormat("dd/MM/yyyy").format(value);
            _startDateDateTime = value;
          } else {
            _endDate = DateFormat("dd/MM/yyyy").format(value);
            _endDateDateTime = value;
          }
        });
      }
    });
  }

  /// [Start and end date widget]
  Widget _startAndEndDateWidget({
    String title,
    String startDate,
    String endDate,
    int index,
  }) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 20.0),
                ),
                Container(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Icon(
                    Icons.calendar_today,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: GestureDetector(
              onTap: () {
                _showDatePicker(index: index);
              },
              child: Container(
                margin: EdgeInsets.only(top: 15.0),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.45,
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Color(0xAAC4C4C4),
                ),
                child: Text(
                  startDate == null ? endDate : startDate,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// [Month title]
  Widget _priceHistoryMonthTitle({String month}) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Text(
        month,
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF274C77),
        ),
      ),
    );
  }

  /// [History card]
  Widget _priceHistoryCard({
    String date,
    String time,
    String priceBeforeChange,
    String priceAfterChange,
    String percent,
    bool isDown,
  }) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.only(
        top: 10.0,
        bottom: 10.0,
        left: 15.0,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$date - $time",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "Trước thay đổi:",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1,
                  ),
                  child: Text(
                    priceBeforeChange + " VNĐ",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "Sau thay đổi:",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.135,
                  ),
                  child: Text(
                    priceAfterChange + " VNĐ",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: isDown ? Color(0xFFF51818) : Color(0xFF274C77),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.11,
                  ),
                  child: Row(
                    children: [
                      Text(
                        percent + " %",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: isDown ? Color(0xFFF51818) : Color(0xFF274C77),
                        ),
                      ),
                      Icon(
                        isDown ? Icons.arrow_downward : Icons.arrow_upward,
                        color: isDown ? Color(0xFFF51818) : Color(0xFF274C77),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// [Widet cho thống kê theo dạng chart]
  LineChartData _priceHistoryLineChart() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 13),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d), width: 1),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          colors: _gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: _gradientColors
                .map(
                  (color) => color.withOpacity(0.3),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
