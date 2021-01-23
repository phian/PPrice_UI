import 'package:flutter/material.dart';
import 'package:pprice_ui/reuse_widgets/custom_app_bar.dart';
import 'package:intl/intl.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class CapNhatGia extends StatefulWidget {
  @override
  CapNhatGiaState createState() => CapNhatGiaState();
}

class CapNhatGiaState extends State<CapNhatGia> {
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('dd/MM/yyyy');
  NumberFormat _priceFormat = NumberFormat("#,##0.000", "vi_VN");
  String datePicked = formatter.format(now);
  String _selectedDate, _selectedTime = null;
  TextEditingController _newPriceController;

  final textController = MaskedTextController(mask: '000.000.000.000');
  var controller;

  List<Widget> _priceUpdateRows;

  @override
  void initState() {
    super.initState();
    _selectedDate = formatter.format(DateTime.now());
    controller = new MoneyMaskedTextController(
      thousandSeparator: '.',
      decimalSeparator: '',
      initialValue: 0,
      precision: 0,
    );
    _newPriceController = TextEditingController();
    _priceUpdateRows = [];
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedTime == null) _selectedTime = TimeOfDay.now().format(context);

    return Scaffold(
      backgroundColor: Color(0xFFE7ECEF),
      appBar: _priceUpdateScreenAppBar(),
      body: _priceuUpdateScreenBody(),
    );
  }

  /// [App Bar]
  Widget _priceUpdateScreenAppBar() {
    return CustomAppBar(
      tenSP: 'Áo sơ mi',
      giaNiemYet: '500.000 VNĐ',
      sKU: 'ABZ982',
      giaGoc: '400.000 VNĐ',
    );
  }

  /// [Body]
  Widget _priceuUpdateScreenBody() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      physics: AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          height: MediaQuery.of(context).size.height * 0.26,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Giá mới (VNĐ):",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.52,
                      height: 50.0,
                      child: TextField(
                        maxLines: 1,
                        onChanged: (value) {
                          _newPriceController.text = _priceFormat.format(
                            int.parse(
                              _newPriceController.text.toString(),
                            ),
                          );
                        },
                        controller: _newPriceController,
                        style: TextStyle(fontSize: 20.0),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          fillColor: Color(0xBBE5E5E5),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ngày áp dụng:",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _showApllyDatePicker();
                      },
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.52,
                        height: 50.0,
                        padding: EdgeInsets.only(top: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xBBE5E5E5),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _selectedDate,
                          style: TextStyle(fontSize: 22.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Giờ áp dụng:",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _showApplyTimePicker();
                      },
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.52,
                        height: 50.0,
                        padding: EdgeInsets.only(top: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xBBE5E5E5),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _selectedTime,
                          style: TextStyle(fontSize: 22.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20.0),
          height: 45.0,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.12,
          ),
          child: FlatButton(
            color: Color(0xFF274C77),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onPressed: () {},
            child: Text(
              "Cập nhật",
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 40.0),
          height: 91.0 * 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                height: 90.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                  color: Color(0xFFDADADA),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "TG áp\n dụng",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Container(
                      child: Text(
                        "Mức giá \n (VNĐ)",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    Text(
                      "Thao tác",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                height: 90.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.02,
                      ),
                      child: Text(
                        "15/01/2021\n 10:00 AM",
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    Container(
                      child: Text(
                        "600.000\n (+10%)",
                        style: TextStyle(fontSize: 15.0),
                      ),
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.055,
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            transform:
                                Matrix4.translationValues(-10.0, 0.0, 0.0),
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFF274C77),
                                    borderRadius: BorderRadius.circular(5.0)),
                                alignment: Alignment.center,
                                width: 100.0,
                                height: 35.0,
                                child: Text(
                                  "Áp dụng ngay",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFC6283D),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              alignment: Alignment.center,
                              width: 50.0,
                              height: 35.0,
                              child: Text(
                                "Xoá",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1.0,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// [Hàm sử dụng đẻ show date picker]
  void _showApllyDatePicker() async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(days: 10000),
      ),
    ).then((value) {
      if (value != null)
        setState(() {
          _selectedDate = formatter.format(value);
        });
    });
  }

  /// [Hàm sử dụng để show time picker]
  void _showApplyTimePicker() async {
    await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value != null) {
        setState(() {
          _selectedTime = value.format(context);
        });
      }
    });
  }

  /// [Widget chứA các thông tin về lịch cập nhật giá]
  Widget _priceUpdateCalendarRow({
    String updateDate,
    String updateTime,
    String updatePrice,
    String percent,
    Color updatePriceColor,
  }) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      height: 90.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.02,
            ),
            child: Text(
              "$updateDate\n $updateTime",
              style: TextStyle(
                color: updatePriceColor,
                fontSize: 15.0,
              ),
            ),
          ),
          Container(
            child: Text(
              "$updatePrice\n ($percent)",
              style: TextStyle(
                color: updatePriceColor,
                fontSize: 15.0,
              ),
            ),
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.055,
            ),
          ),
          Container(
            child: Row(
              children: [
                Container(
                  transform: Matrix4.translationValues(-10.0, 0.0, 0.0),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF274C77),
                          borderRadius: BorderRadius.circular(5.0)),
                      alignment: Alignment.center,
                      width: 100.0,
                      height: 35.0,
                      child: Text(
                        "Áp dụng ngay",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFC6283D),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    alignment: Alignment.center,
                    width: 50.0,
                    height: 35.0,
                    child: Text(
                      "Xoá",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
