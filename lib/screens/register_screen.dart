import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';
import '../constants/constant.dart';
import '../constants/text_style.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: appDrawer(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: screenPadding,
            decoration: background,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Icon(
                        Icons.person_add_outlined,
                        size: 40.sp,
                      ),
                      Text(
                        'Register on ForLet',
                        style: AppTextStyles.heading20,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Full Name',
                  style: AppTextStyles.body18.copyWith(color: greyShade3),
                ),
                SizedBox(
                  height: 2.h,
                ),
                TextField(
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    hintText: 'First Name',
                    prefixIcon: Icon(Icons.info),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                TextField(
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    hintText: 'Last Name',
                    prefixIcon: Icon(Icons.info),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Gender',
                  style: AppTextStyles.body18.copyWith(color: greyShade3),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(225, 225, 225, 1)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    value: 'Male',
                    isExpanded: true,
                    hint: Text(
                      'Select a Gender',
                      style: TextStyle(color: greyShade3, fontSize: 16),
                    ),
                    items: [
                      'Male',
                      'Female',
                    ]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Address',
                  style: AppTextStyles.body18.copyWith(color: greyShade3),
                ),
                SizedBox(
                  height: 2.h,
                ),
                TextField(
                  onChanged: (value) {},
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'House Number (e.g. 3)',
                    prefixIcon: Icon(Icons.info),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                TextField(
                  onChanged: (value) {},
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Street Name (e.g. Bode Thomas Street)',
                    prefixIcon: Icon(Icons.info),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                TextField(
                  onChanged: (value) {},
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Area Name (e.g. Aguda Surulere)',
                    prefixIcon: Icon(Icons.info),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(225, 225, 225, 1)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    value: 'Kogi',
                    isExpanded: true,
                    hint: Text(
                      'Select a State',
                      style: TextStyle(color: greyShade3, fontSize: 16),
                    ),
                    items: ['Kogi', 'Kwara', 'Kaduna']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(225, 225, 225, 1)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    value: 'Abuja',
                    isExpanded: true,
                    hint: Text(
                      'Select an L.G.A',
                      style: TextStyle(color: greyShade3, fontSize: 16),
                    ),
                    items: ['Abuja', 'Lagos', 'Benin']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Others',
                  style: AppTextStyles.body18.copyWith(color: greyShade3),
                ),
                SizedBox(
                  height: 2.h,
                ),
                TextField(
                  onChanged: (value) {},
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                TextField(
                  onChanged: (value) {},
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone_outlined),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
                SizedBox(
                  height: 2.h,
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
                  height: 8.0,
                ),
                TextField(
                  onChanged: (value) {},
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
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
                      fixedSize: const Size(350, 50),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
