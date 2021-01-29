import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PriceHistoryScreen extends StatefulWidget {
  PriceHistoryScreen({Key key}) : super(key: key);

  @override
  _PriceHistoryScreenState createState() => _PriceHistoryScreenState();
}

class _PriceHistoryScreenState extends State<PriceHistoryScreen> {
  DateFormat formatter = DateFormat('dd/MM/yyyy');
  String _startDate, _endDate;
  DateTime _startDateDateTime, _endDateDateTime;
  List<Color> _gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  bool _isBarChart;

  List<String> _dateList,
      _hourList,
      _monthList,
      _changedPriceList,
      _percentList;
  List<bool> _isDownList;
  List<Widget> _priceHistoryCards;
  List<FlSpot> _allPriceSpots, _priceSpotsForChart;

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
    _initListDatas(_startDateDateTime.month, _endDateDateTime.month);
    return Scaffold(
      backgroundColor: Color(0xFFE7ECEF),
      appBar: _priceHistoryScreenAppBar(),
      body: _priceHistoryScreenBody(),
    );
  }

  /// [Khỏi tạo các giá trị cho các list]
  void _initListDatas(int startMonth, int endMonth) {
    // Các data cố định
    _changedPriceList = [
      "150.000",
      "155.000",
      "160.000",
      "140.000",
      "150.000",
      "200.000",
      "190.000",
      "195.000",
      "180.000",
      "210.000",
      "215.000",
      "200.000",
      "205.000",
    ];
    _percentList = [
      "1.03",
      "1.03",
      "1.14",
      "1.07",
      "1.33",
      "1.05",
      "1.02",
      "1.08",
      "1.16",
      "1.02",
      "1.07",
      "1.02",
    ];
    _isDownList = [
      false,
      false,
      true,
      false,
      false,
      true,
      false,
      true,
      false,
      false,
      true,
      false,
    ];
    _dateList = [
      "10/01/2021",
      "10/02/2021",
      "10/03/2021",
      "10/4/2021",
      "10/05/2021",
      "12/06/2021",
      "10/07/2021",
      "10/08/2021",
      "11/09/2021",
      "12/10/2021",
      "10/11/2021",
      "10/12/2021",
    ];
    _hourList = [
      "09:00 AM",
      "15:15 PM",
      "20:45 PM",
      "10:00 AM",
      "12:00 PM",
      "08:00 AM",
      "16:00 PM",
      "17:00 PM",
      "07:00 AM",
      "11:00 AM",
      "19:00 PM",
      "09:30 AM",
    ];
    _allPriceSpots = [
      FlSpot(0, double.parse(_percentList[0])),
      FlSpot(1, double.parse(_percentList[1])),
      FlSpot(2, double.parse(_percentList[2])),
      FlSpot(3, double.parse(_percentList[3])),
      FlSpot(4, double.parse(_percentList[4])),
      FlSpot(5, double.parse(_percentList[5])),
      FlSpot(6, double.parse(_percentList[6])),
      FlSpot(7, double.parse(_percentList[7])),
      FlSpot(8, double.parse(_percentList[8])),
      FlSpot(9, double.parse(_percentList[9])),
      FlSpot(10, double.parse(_percentList[10])),
      FlSpot(11, double.parse(_percentList[11])),
    ];

    // Phần khởi tạo các data dựa trên ngày đượ chọn
    _monthList = [];
    _priceHistoryCards = [];
    _priceSpotsForChart = [];
    if (startMonth == endMonth) {
      _monthList.add(startMonth.toString());
      _priceHistoryCards.add(
        _priceHistoryCard(
          date: _dateList[startMonth],
          priceBeforeChange: _changedPriceList[startMonth],
          priceAfterChange: _changedPriceList[startMonth + 1],
          time: _hourList[startMonth],
          percent: _percentList[endMonth],
          isDown: _isDownList[endMonth],
        ),
      );
      _priceSpotsForChart.add(_allPriceSpots[startMonth]);
      return;
    }
    for (int i = startMonth; i <= endMonth; i++) {
      _monthList.add(i.toString());
    }
    for (int i = startMonth; i <= endMonth; i++) {
      _priceHistoryCards.add(
        _priceHistoryCard(
          date: _dateList[i - 1],
          priceBeforeChange: _changedPriceList[i],
          priceAfterChange: _changedPriceList[i + 1],
          time: _hourList[i],
          percent: _percentList[i],
          isDown: _isDownList[i],
        ),
      );
      _priceSpotsForChart.add(_allPriceSpots[i - 1]);
    }
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
                          ...List.generate(
                              _monthList.length + _priceHistoryCards.length,
                              (index) {
                            if (index % 2 == 0) {
                              return _priceHistoryMonthTitle(
                                index: index,
                                month:
                                    "Tháng ${_monthList[(index / 2).toInt()]} - ${DateTime.now().year}",
                              );
                            } else {
                              return _priceHistoryCards[(index / 2).toInt()];
                            }
                          }),
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
      initialDate: index == 0 ? _startDateDateTime : _endDateDateTime,
      firstDate: DateTime.now().subtract(
        Duration(days: 10000),
      ),
      lastDate: DateTime.now().add(
        Duration(days: 10000),
      ),
    ).then((value) {
      if (value != null) {
        setState(() {
          if (index == 0) {
            if (value.isAfter(_endDateDateTime)) {
              showOkAlertDialog(
                context: context,
                title: 'Thông báo',
                message:
                    "Ngày bắt đầu phải nhỏ hơn ngày kết thúc! Vui lòng kiểm tra lại",
                alertStyle: AdaptiveStyle.material,
              );
              return;
            }
            _startDate = DateFormat("dd/MM/yyyy").format(value);
            _startDateDateTime = value;
            _initListDatas(_startDateDateTime.month, _endDateDateTime.month);
          } else {
            if (value.isBefore(_startDateDateTime)) {
              showOkAlertDialog(
                context: context,
                title: 'Thông báo',
                message:
                    "Ngày kết thúc phải lớn hơn ngày bắt đầu! Vui lòng kiểm tra lại",
                alertStyle: AdaptiveStyle.material,
              );
              return;
            }
            _endDate = DateFormat("dd/MM/yyyy").format(value);
            _endDateDateTime = value;
            _initListDatas(_startDateDateTime.month, _endDateDateTime.month);
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
  Widget _priceHistoryMonthTitle({String month, int index}) {
    return Container(
      margin: EdgeInsets.only(top: index == 0 ? 10.0 : 30.0),
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
                    left: MediaQuery.of(context).size.width * 0.061,
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
                    left: MediaQuery.of(context).size.width * 0.1,
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
                    left: MediaQuery.of(context).size.width * 0.05,
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
                return '1%';
              case 3:
                return '5%';
              case 5:
                return '10%';
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
            ...List.generate(
              _priceSpotsForChart.length,
              (index) {
                return _priceSpotsForChart[index];
              },
            ),
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
