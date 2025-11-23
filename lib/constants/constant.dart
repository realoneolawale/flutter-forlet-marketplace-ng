import 'package:flutter/material.dart';
import 'package:forlet_marketplace_ng/constants/text_style.dart';
import 'package:forlet_marketplace_ng/screens/home_screen.dart';
import 'package:forlet_marketplace_ng/screens/login_screen.dart';
import 'package:sizer/sizer.dart';

import 'colors.dart';

const String AppName = "ForLet Marketplace";

// textbox outlineInputeBorder style
const border = OutlineInputBorder(
  borderSide: BorderSide(color: Color.fromRGBO(225, 225, 225, 1)),
  borderRadius: BorderRadius.horizontal(
      left: Radius.circular(25.0), right: Radius.circular(25.0)),
);

AppBar appBar = AppBar(
  leading: null,
  title: Row(
    children: [
      Image.asset(
        'assets/images/splash_screen/forlet-logo.png',
        width: 30,
        height: 30,
      ),
      Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          AppName,
          style: AppTextStyles.heading20,
        ),
      ),
    ],
  ),
  centerTitle: true,
);

Drawer appDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: turquoise),
          child: Row(
            children: [
              Image.asset(
                'assets/images/splash_screen/forlet-logo.png',
                width: 30,
                height: 30,
              ),
              SizedBox(
                width: 2.w,
              ),
              Text("$AppName Menu"),
            ],
          ),
        ),
        ListTile(
          title: Row(
            children: [
              Icon(Icons.home_outlined),
              SizedBox(
                width: 2.w,
              ),
              Text('Home'),
            ],
          ),
          onTap: () => viewHomeScreen(context),
        ),
        ListTile(
          title: Row(
            children: [
              Icon(Icons.add_card_outlined),
              SizedBox(
                width: 2.w,
              ),
              Text('Post on $AppName'),
            ],
          ),
          onTap: () {},
        ),
        ListTile(
          title: Row(
            children: [
              Icon(Icons.perm_contact_cal_outlined),
              SizedBox(
                width: 2.w,
              ),
              Text('My Account'),
            ],
          ),
          onTap: () => viewLoginScreen(context),
        ),
      ],
    ),
  );
}

// app functions
void viewLoginScreen(BuildContext context) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
}

void viewHomeScreen(BuildContext context) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
}
