import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pprice_ui/ui/product_list_screen.dart';

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _userNameController, _passwordController;
  bool _isCorrect, _isObscureText;

  @override
  void initState() {
    super.initState();

    _userNameController = new TextEditingController();
    _passwordController = new TextEditingController();

    _isCorrect = true;
    _isObscureText = false;
  }

  @override
  void dispose() {
    super.dispose();

    _userNameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          _loginScreenBackground(),
          _appLogo(),
          _loginScreenWidgets(),
        ],
      ),
    );
  }

  Widget _appLogo() {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.035,
      ),
      child: Image.asset(
        "images/app_logo.png",
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.3,
      ),
    );
  }

  Widget _loginScreenBackground() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Image.asset(
        "images/login_screen_background.png",
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _loginScreenWidgets() {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.47,
        left: 37.0,
        right: 37.0,
      ),
      alignment: Alignment.center,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          children: [
            _loginInputWidget(Icons.account_circle_rounded, "Username",
                _isObscureText, _userNameController),
            Container(
              transform: Matrix4.translationValues(0.0, -0.0, 0.0),
              child: _loginInputWidget(
                  Icons.lock, "Password", !_isObscureText, _passwordController),
            ),
            SizedBox(height: 20.0),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                10.0,
              )),
              onPressed: () {
                if (_userNameController.text.toLowerCase() == "admin" &&
                    _passwordController.text.toLowerCase() == "1") {
                  Navigator.of(context).pushReplacement(
                    PageTransition(
                      type: PageTransitionType.fade,
                      duration: Duration(milliseconds: 500),
                      child: ProductListScreen(),
                    ),
                  );
                } else {
                  setState(() {
                    _userNameController.clear();
                    _passwordController.clear();
                    _isCorrect = false;
                  });
                }
              },
              height: 50.0,
              minWidth: 170.0,
              child: Text(
                "Đăng nhập",
                style: TextStyle(
                  fontSize: 25.0,
                  color: Color(0xFFE7ECEF),
                ),
              ),
              color: Color(0xFF363740),
            )
          ],
        ),
      ),
    );
  }

  Widget _loginInputWidget(
    IconData icon,
    String hintText,
    bool isObscureText,
    TextEditingController _controller,
  ) {
    return TextField(
      controller: _controller,
      obscureText: isObscureText,
      style: TextStyle(
        fontSize: 20.0,
      ),
      decoration: InputDecoration(
        fillColor: Color(0xFFced4da),
        filled: true,
        errorText: () {
          if (_isCorrect)
            return "";
          else {
            return "*Login info is not correct";
          }
        }(),
        errorStyle: TextStyle(
          fontSize: 20.0,
          color: Color(0xFFef233c),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0.0,
          ),
          borderRadius: BorderRadius.circular(
            15.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0.0,
          ),
          borderRadius: BorderRadius.circular(
            15.0,
          ),
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            width: 1.0,
            color: Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        prefixIcon: Icon(
          icon,
          color: Color(0xFF343a40),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 20.0,
          color: Color(0xFF6c757d),
        ),
      ),
    );
  }
}
