import 'package:flutter/material.dart';
import 'package:mobile_test/overlays.dart';
import 'package:mobile_test/pages/home/homepage.dart';
import 'package:mobile_test/pages/login.dart';
import '../styles.dart';

final buttonStyle = Styles.yellowButtonStyle;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;

  @override
  void initState(){
    super.initState();

    firstnameController.addListener(() => setState(() {}));
    lastnameController.addListener(() => setState(() {}));
    usernameController.addListener(() => setState(() {}));
    passwordController.addListener(() => setState(() {}));
    confirmpasswordController.addListener(() => setState(() {}));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBarBlank(),
      bottomNavigationBar: BottomBarBlank(),
      body: Center(
        child: ListView(
         
          children: <Widget>[

          //LOGIN stripe
            Material(
              elevation: 4,
              child: Container(
                color: Styles.schemeMain.secondary,
                width: 412,
                height: 89,
                child: Center(
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(
                      color: Styles.schemeMain.primary,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Mulish',
                    ),
                  ),
                ),
              ),
            ),

            Container(
              height:45
            ),

            //textboxes and button
            Form(
              child: Column(
                spacing: 40,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
            
                  //First name textbox
                  Container(
                    color: Colors.grey[300],
                    padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
                    width: 336,
                    height: 65,
                    child: TextField(
                      controller: firstnameController,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Styles.schemeMain.primary,
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 4.0,
                              bottom: 4.0,
                              top: 4.0
                          ),
                        hintText: 'First Name',
                        hintStyle: Styles.fieldTextStyle,
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  //Last Name textbox
                  Container(
                    color: Colors.grey[300],
                    padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
                    width: 336,
                    height: 65,
                    child: TextField(
                      controller: lastnameController,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Styles.schemeMain.primary,
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 4.0,
                              bottom: 4.0,
                              top: 4.0
                          ),
                        hintText: 'Last Name',
                        hintStyle: Styles.fieldTextStyle,
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  // Username Textbox
                  Container(
                    color: Colors.grey[300],
                    padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
                    width: 336,
                    height: 65,
                    child: TextField(
                      controller: usernameController,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Styles.schemeMain.primary,
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 4.0,
                              bottom: 4.0,
                              top: 4.0
                          ),
                        hintText: 'Username',
                        hintStyle: Styles.fieldTextStyle,
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  //password textbox
                  Container(
                    color: Colors.grey[300],
                    padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
                    width: 336,
                    height: 65,
                    child: TextField(
                      controller: passwordController,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Styles.schemeMain.primary,
                        fontFamily: '',
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: 4.0,
                            bottom: 4.0,
                            top: 4.0
                        ),
                        hintText: 'Password',
                        hintStyle: Styles.fieldTextStyle,
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: isPasswordVisible
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          color: Styles.schemeMain.primary,
                          onPressed: () =>
                              setState(() =>
                              isPasswordVisible = !isPasswordVisible),
                        ),
                      ),
                      obscureText: isPasswordVisible,
                    ),
                  ),
                  
                  // Confirm Password textbox
                  Container(
                    color: Colors.grey[300],
                    padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
                    width: 336,
                    height: 65,
                    child: TextField(
                      controller: confirmpasswordController,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Styles.schemeMain.primary,
                        fontFamily: '',
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: 4.0,
                            bottom: 4.0,
                            top: 4.0
                        ),
                        hintText: 'Confirm Password',
                        hintStyle: Styles.fieldTextStyle,
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: isConfirmPasswordVisible
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          color: Styles.schemeMain.primary,
                          onPressed: () =>
                              setState(() =>
                              isConfirmPasswordVisible = !isConfirmPasswordVisible),
                        ),
                      ),
                      obscureText: isConfirmPasswordVisible,
                    ),
                  ),

                  //Create Account button
                  MaterialButton(
                    onPressed: () {
                      //temp solution; ideally would be passed as json for login endpoint or something like that
                      print('firstname: ${firstnameController.text}');
                      print('lastname: ${lastnameController.text}');
                      print('username: ${usernameController.text}');
                      print('password: ${passwordController.text}');
                      print('confirm password: ${confirmpasswordController.text}');
            
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                    elevation: 4,
                    color: Styles.schemeMain.secondary,
                    shape: Styles.buttonShape,
                    height: 70,
                    minWidth: 350,
                    child: Text(
                      'Create Account',
                      style: Styles.buttonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
            
            // Login Hyperlink
            Container(
              width: 300,
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Center(
                child: RichText(text: TextSpan(
                children: [
                  TextSpan( 
                    text: 'Already Registered? ', 
                    style: Styles.smallTextStyle,
                  ),

                  // FIXME - Make text go to Login page.
                  TextSpan
                  ( 
                    text: 'Login here.',
                    style: Styles.linkSmallTextStyle,
                  ),
                
                ])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
