import 'package:flutter/material.dart';
import 'cap_nhat_gia.dart';
import 'gia_doi_thu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF274C77),
      ),
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE7ECEF),
      appBar: AppBar(
        title: Text('Danh sach san pham'),
      ),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              child: Text('Cap nhat gia'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CapNhatGia(),
                  ),
                );
              },
            ),
            RaisedButton(
              child: Text('Gia doi thu'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => GiaDoiThu(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
