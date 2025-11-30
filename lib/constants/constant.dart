import 'package:ForLetMarketplaceNG/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../screens/home_screen.dart';
import '../screens/location_screen.dart';
import '../screens/login_screen.dart';
import 'colors.dart';

const String AppName = "ForLet Marketplace";

// textbox outlineInputeBorder style
const border = OutlineInputBorder(
  borderSide: BorderSide(color: Color.fromRGBO(225, 225, 225, 1)),
  borderRadius: BorderRadius.horizontal(
      left: Radius.circular(25.0), right: Radius.circular(25.0)),
);

// app-wide box decoration
Decoration background = BoxDecoration(
  gradient: LinearGradient(
    colors: [turquoise, mustard],
  ),
);

// app-wide padding
EdgeInsetsGeometry screenPadding =
    const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0);

// app-wide app bar
AppBar appBar = AppBar(
  leading: null,
  title: Row(
    children: [
      Image.asset(
        'assets/images/splash_screen/forlet-logo.png',
        width: 30,
        height: 30,
      ),
      SizedBox(
        width: 2.w,
      ),
      Text(
        AppName,
        style: AppTextStyles.heading20,
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
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [turquoise, mustard],
            ),
          ),
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
        ListTile(
          title: Row(
            children: [
              Icon(Icons.location_on_outlined),
              SizedBox(
                width: 2.w,
              ),
              Text('Update Location'),
            ],
          ),
          onTap: () => viewLocationScreen(context),
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

void viewLocationScreen(BuildContext context) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LocationScreen()),
      (route) => false);
}
