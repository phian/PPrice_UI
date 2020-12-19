import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class CapNhatGia extends StatefulWidget {
  @override
  CapNhatGiaState createState() => CapNhatGiaState();
}

class CapNhatGiaState extends State<CapNhatGia> {
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('dd/MM/yyyy');
  String datePicked = formatter.format(now);

  final textController = MaskedTextController(mask: '000.000.000.000');
  var controller = new MoneyMaskedTextController(
    thousandSeparator: '.',
    decimalSeparator: '',
    initialValue: 0,
    precision: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE7ECEF),
      appBar: CustomAppBar(
        tenSP: 'Áo sơ mi',
        giaNiemYet: '500.000 VNĐ',
        ngayApDung: '08/11/2020',
        sKU: 'ABZ982',
        giaGoc: '400.000 VNĐ',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, left: 10),
            child: Text(
              'Cập nhật giá mới',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                height: 180,
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Giá mới',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Color(0xFFE5E5E5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextField(
                          controller: controller,
                          //textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: Color(0xFF274C77),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            suffix: Text(
                              'VNĐ',
                              style: TextStyle(
                                  color: Color(0xFF274C77),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            'Ngày áp dụng:  ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          Expanded(
                            child: FlatButton(
                              color: Color(0xFFE5E5E5),
                              child: Text(
                                datePicked,
                                style: TextStyle(fontSize: 19),
                              ),
                              onPressed: () {
                                DatePicker.showDatePicker(
                                  context,
                                  showTitleActions: true,
                                  onConfirm: (date) {
                                    setState(() {
                                      datePicked = formatter.format(date);
                                    });
                                  },
                                );
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              RaisedButton(
                child: Text(
                  'Cập nhật',
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
        ],
      ),
    );
  }
}
