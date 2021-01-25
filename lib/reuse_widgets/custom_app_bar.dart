import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  double _height = 185.0;
  String tenSP;
  String giaNiemYet;
  String sKU;
  String giaGoc;

  CustomAppBar({
    this.tenSP,
    this.giaNiemYet,
    this.sKU,
    this.giaGoc,
  });

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height * 0.25;
    return Container(
      height: _height,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      color: Color(0xFF274C77),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              BackButton(
                color: Colors.white,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 7.0),
                  child: Text(
                    tenSP,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.info_outline),
                onPressed: () {},
                color: Colors.white,
              )
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.25 * 0.1),
          Text(
            'Giá niêm yết',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          Text(
            giaNiemYet,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.25 * 0.1),
          Container(
            transform: Matrix4.translationValues(0.0, -5.0, 0.0),
            padding: EdgeInsets.only(top: 15.0, left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'SKU: ' + sKU,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Giá gốc: ' + giaGoc,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_height);
}
