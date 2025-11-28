import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';
import '../constants/constant.dart';
import '../constants/text_style.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
                      Icons.settings_outlined,
                      size: 40.sp,
                    ),
                    Text(
                      'Password Reset',
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
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.info),
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
                    'Reset',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
