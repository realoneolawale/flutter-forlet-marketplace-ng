import 'package:flutter/material.dart';
import 'package:forlet_marketplace_ng/constants/text_style.dart';
import 'package:forlet_marketplace_ng/screens/home_screen.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';
import '../constants/constant.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  // app function
  void viewHomeScreen() {
    void viewLocationScreen() {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: appDrawer(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 8.0),
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
                      Icons.location_on_outlined,
                      size: 40.sp,
                    ),
                    Text(
                      'Change Location',
                      style: AppTextStyles.heading20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              DropdownButton<String>(
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
              SizedBox(
                height: 2.h,
              ),
              DropdownButton<String>(
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
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: viewHomeScreen,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: turquoise,
                    //minimumSize: const Size(double.infinity, 50),
                    fixedSize: const Size(350, 50),
                  ),
                  child: const Text(
                    'Update Location',
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
