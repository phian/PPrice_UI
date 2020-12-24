import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pprice_ui/menu_items.dart';
import 'package:pprice_ui/ui/cap_nhat_gia.dart';
import 'package:pprice_ui/ui/gia_doi_thu.dart';

class ProductListScreen extends StatefulWidget {
  ProductListScreen({Key key}) : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  TextEditingController _searchBoxController;

  List<String> _productNames,
      _productSKUs,
      _productAmounts,
      _productOriginalPrices,
      _productListedPrices,
      _productProducer,
      _searchBoxSuggestions;

  int _totalProducts;

  List<MenuItem> _menuItems;
  CustomPopupMenuController _menuController = CustomPopupMenuController();

  GlobalKey<AutoCompleteTextFieldState<String>> _searchBoxKey = new GlobalKey();

  @override
  void initState() {
    super.initState();

    _searchBoxController = new TextEditingController();
    _initProductInfos();
    _totalProducts = _productNames.length;

    _menuItems = [
      MenuItem("Giá tăng dần", Icons.arrow_upward),
      MenuItem("Giá giảm dần", Icons.arrow_downward),
      MenuItem("Hãng sản xuất", Icons.supervised_user_circle),
    ];
  }

  @override
  void dispose() {
    super.dispose();

    _searchBoxController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFE7ECEF),
        appBar: _productListScreenAppbBar(),
        body: _prooductListScreenBody(),
      ),
    );
  }

  // App Bar
  Widget _productListScreenAppbBar() {
    return AppBar(
      backgroundColor: Color(0xFF274C77),
      title: Text(
        "Danh sách sản phẩm",
        style: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          fontFamily: "robotoslab",
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {},
        icon: Icon(Icons.menu_rounded),
      ),
    );
  }
  //==========================================================================//

  // Body
  Widget _prooductListScreenBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            _searchBox(),
            _filterButton(),
          ],
        ),
        _totalProductAmount(_totalProducts),
        _productList(),
      ],
    );
  }

  Widget _searchBox() {
    return Container(
      padding: EdgeInsets.only(
        left: 10.0,
        right: MediaQuery.of(context).size.width * 0.15,
        top: MediaQuery.of(context).size.height * 0.03,
      ),
      child: SimpleAutoCompleteTextField(
        key: _searchBoxKey,
        controller: _searchBoxController,
        style: TextStyle(
          fontSize: 22.0,
        ),
        submitOnSuggestionTap: true,
        clearOnSubmit: true,
        decoration: InputDecoration(
          fillColor: Color(0xFFced4da),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 0.0,
            ),
          ),
          hintText: "Tìm sản phẩm",
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xFF343a40),
          ),
          hintStyle: TextStyle(
            fontSize: 20.0,
            fontFamily: "robotoslab",
            color: Color(0xFF6c757d),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 0.0,
            ),
            borderRadius: BorderRadius.circular(
              15.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
        ),
        suggestions: _searchBoxSuggestions,
      ),
    );
  }

  Widget _filterButton() {
    return Container(
      alignment: Alignment.topRight,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.05,
        right: 15.0,
      ),
      child: Container(
        width: 35.0,
        height: 35.0,
        child: CustomPopupMenu(
          child: Icon(
            Icons.filter_alt_sharp,
            size: 35.0,
          ),
          menuBuilder: () => ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
              color: const Color(0xFF4C4C4C),
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: _menuItems
                      .map(
                        (item) => GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: _menuController.hideMenu,
                          child: Container(
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  item.icon,
                                  size: 22.0,
                                  color: Colors.white,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    item.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
          pressType: PressType.singleClick,
          verticalMargin: -10,
          controller: _menuController,
        ),
      ),
    );
  }

  Widget _totalProductAmount(int totalProducts) {
    return Container(
      padding: EdgeInsets.only(
        top: 20.0,
        left: 15.0,
      ),
      child: Text(
        "Tổng: " + totalProducts.toString() + " sản phẩm",
        style: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w500,
          fontFamily: "robotoslab",
        ),
      ),
    );
  }

  // Listview sản phẩm
  Widget _productList() {
    return Container(
      padding: EdgeInsets.only(top: 15.0),
      height: MediaQuery.of(context).size.height * 0.73,
      child: ListView.separated(
          padding: EdgeInsets.only(
            left: 15.0,
            right: 15.0,
            bottom: 20.0,
          ),
          physics: AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          itemBuilder: (context, index) {
            return _productCard(
                index,
                _productNames[index],
                _productSKUs[index],
                _productAmounts[index],
                _productOriginalPrices[index],
                _productListedPrices[index]);
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 10.0,
            );
          },
          itemCount: _productNames.length),
    );
  }

  Widget _productCard(
    int index,
    String productName,
    String productSKU,
    String productAmount,
    String orignalPrice,
    String listedPrice,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          20.0,
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.26,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              top: 15.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    _productNames[index],
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "robotoslab",
                    ),
                    maxLines: 2,
                  ),
                ),
                Text(
                  "SL: " + _productAmounts[index],
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: "robotoslab",
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 3.0,
              left: 15.0,
            ),
            child: Text(
              _productSKUs[index] + " - " + _productProducer[index],
              style: TextStyle(
                fontSize: 16.0,
                color: Color(0xFF6E6E6E),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 15.0,
              left: 15.0,
              right: 15.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Giá gốc: ",
                        style: TextStyle(
                          fontSize: 22.0,
                          fontFamily: "robotoslab",
                          color: Color(0xFF274C77),
                        ),
                      ),
                      Text(
                        _productOriginalPrices[index],
                        style: TextStyle(
                          fontSize: 22.0,
                          fontFamily: "robotoslab",
                          color: Color(0xFF274C77),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 7.0,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Giá niêm yết: ",
                        style: TextStyle(
                          fontSize: 22.0,
                          fontFamily: "robotoslab",
                          color: Color(0xFFDA1E37),
                        ),
                      ),
                      Text(
                        _productListedPrices[index],
                        style: TextStyle(
                          fontSize: 22.0,
                          fontFamily: "robotoslab",
                          color: Color(0xFFDA1E37),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Divider(
                  thickness: 0.8,
                  height: 0.0,
                ),
                Container(
                  padding: EdgeInsets.only(top: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(
                        child: Text(
                          "Lịch sử giá",
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        onPressed: () {},
                      ),
                      MaterialButton(
                        child: Text("Giá thị trường",
                            style: TextStyle(
                              fontSize: 15.0,
                            )),
                        onPressed: () {
                          Navigator.of(context).push(
                            PageTransition(
                              type: PageTransitionType.fade,
                              duration: Duration(milliseconds: 200),
                              child: GiaDoiThu(),
                            ),
                          );
                        },
                      ),
                      MaterialButton(
                        child: Text("Cập nhật giá",
                            style: TextStyle(
                              fontSize: 15.0,
                            )),
                        onPressed: () {
                          Navigator.of(context).push(
                            PageTransition(
                              type: PageTransitionType.fade,
                              duration: Duration(milliseconds: 250),
                              child: CapNhatGia(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //==========================================================================//

  void _initProductInfos() {
    _productNames = [
      "Áo sơ mi",
      "Quần jean nữ",
      "Áo thun nam",
      "Áo khoác cổ lọ",
      "Quần tây nam",
      "Giày thể thao nam",
      "Dép đi trong nhà",
    ];
    _productSKUs = [
      "ABC",
      "DEF",
      "GHI",
      "JKL",
      "MNO",
      "QRS",
      "TUV",
    ];
    _productAmounts = [
      "100",
      "150",
      "120",
      "200",
      "300",
      "145",
      "215",
    ];
    _productListedPrices = [
      "150.000",
      "250.000",
      "100.000",
      "300.000",
      "200.000",
      "500.000",
      "50.000",
    ];
    _productOriginalPrices = [
      "100.000",
      "190.000",
      "80.000",
      "250.000",
      "120.000",
      "400.000",
      "30.000",
    ];
    _productProducer = [
      "Việt Tiến",
      "Sông Hồng",
      "Nhà Bè NBC",
      "Gia định Giditex",
      "Công ty 23/9",
      "Vinatex",
      "Hanosimex",
    ];

    _searchBoxSuggestions = new List<String>();
    for (int i = 0; i < _productNames.length; i++) {
      _searchBoxSuggestions.add(_productNames[i]);
      _searchBoxSuggestions.add(_productSKUs[i]);
      _searchBoxSuggestions.add(_productProducer[i]);
    }
  }
}
