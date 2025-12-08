import 'package:ForLetMarketplaceNG/models/dtos/login_request_dto.dart';
import 'package:ForLetMarketplaceNG/screens/home_screen.dart';
import 'package:ForLetMarketplaceNG/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';
import '../constants/constant.dart';
import '../constants/text_style.dart';
import '../provider/home_provider.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // app variable
  late String emailOrPhone, password = "";
  String? errorText;
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

  void onTap() async {
    if (emailOrPhone.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all fields to login')));
    } else {
      // perform the login process
      LoginRequestDto dto =
          LoginRequestDto(username: emailOrPhone, password: password);
      dynamic response = await Future.microtask(() =>
          Provider.of<HomeProvider>(context, listen: false).loginUser(dto));
      print("CREDENTIALS: $emailOrPhone $password");
      if (response == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('If an account exists, login is invalid.')));
      } else {
        // login is successful
        print("LOGIN RESPONSE: $response");
        // go to home page
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    final response = provider.loginResponseDto;

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        drawer: provider.loginResponseDto == null
            ? appDrawer(context)
            : loginAppDrawer(context),
        body: Container(
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
                onChanged: (value) {
                  setState(() {
                    if (value.isEmpty) {
                      errorText = "Email or phone cannot be empty";
                    } else {
                      errorText = null;
                      emailOrPhone = value;
                    }
                  });
                },
                decoration: InputDecoration(
                    hintText: 'Email or phone number',
                    prefixIcon: Icon(Icons.info),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                    errorText: errorText,
                    errorStyle: errorTextStyle),
              ),
              SizedBox(
                height: 1.h,
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    if (value.isEmpty) {
                      errorText = "Email or phone cannot be empty";
                    } else {
                      errorText = null;
                      password = value;
                    }
                  });
                },
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
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: turquoise,
                    //minimumSize: const Size(double.infinity, 50),
                    fixedSize: const Size(350, 50),
                  ),
                  child: provider.isLoading
                      ? CircularProgressIndicator()
                      : const Text(
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
