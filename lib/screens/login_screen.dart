import 'package:ForLetMarketplaceNG/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';
import '../constants/constant.dart';
import '../constants/text_style.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // app variable
  TextEditingController usernameTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  // app functions
  void viewRegisterScreen() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => RegisterScreen()),
        (route) => false);
  }

  void viewForgotPasswordScreen() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: appDrawer(context),
      body: SafeArea(
        child: Container(
          padding: screenPadding,
          decoration: background,
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Icon(
                      Icons.login_rounded,
                      size: 40.sp,
                    ),
                    Text(
                      'Login to ForLet Marketplace',
                      style: AppTextStyles.heading20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              TextField(
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: 'Email or phone number',
                  prefixIcon: Icon(Icons.info),
                  border: border,
                  enabledBorder: border,
                  focusedBorder: border,
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              TextField(
                onChanged: (value) {},
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.password),
                  border: border,
                  enabledBorder: border,
                  focusedBorder: border,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: turquoise,
                    //minimumSize: const Size(double.infinity, 50),
                    fixedSize: const Size(350, 50),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              InkWell(
                onTap: viewRegisterScreen,
                child: Text(
                  'Not yet a member? Click here to register.',
                  style: AppTextStyles.body16,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              InkWell(
                onTap: viewForgotPasswordScreen,
                child: Text(
                  'Forgot password? Click here to reset.',
                  style: AppTextStyles.body16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
