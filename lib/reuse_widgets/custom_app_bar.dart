import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double _height = 170.0;
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
    return Container(
      height: _height,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      color: Color(0xFF274C77),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              BackButton(
                color: Colors.white,
              ),
              Expanded(
                child: Text(
                  tenSP,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
          SizedBox(height: 5),
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
          Padding(
            padding: EdgeInsets.only(top: 20, left: 8, right: 8, bottom: 5),
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
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_height);
}
