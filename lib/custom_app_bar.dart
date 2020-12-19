import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double _height = 185.0;
  String tenSP;
  String giaNiemYet;
  String sKU;
  String giaGoc;
  String ngayApDung;

  CustomAppBar({
    this.tenSP,
    this.giaNiemYet,
    this.sKU,
    this.giaGoc,
    this.ngayApDung,
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
          Text(
            '(' + ngayApDung + ')',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white60,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15, left: 8, right: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'SKU: ' + sKU,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
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
