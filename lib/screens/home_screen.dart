import 'package:flutter/material.dart';
import 'package:forlet_marketplace_ng/constants/colors.dart';
import 'package:forlet_marketplace_ng/constants/constant.dart';
import 'package:forlet_marketplace_ng/constants/text_style.dart';
import 'package:forlet_marketplace_ng/screens/location_screen.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // app functions
  void viewLocationScreen() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LocationScreen()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: appDrawer(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
          child: Column(
            children: [
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
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
                      "Hi Charlton,",
                      style: AppTextStyles.body14,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              InkWell(
                onTap: viewLocationScreen,
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.location_on_outlined),
                      Text(
                        'L.G.A >> State',
                        style: AppTextStyles.body14,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                children: [
                  const Expanded(
                    child: TextField(
                      //onChanged: () {},
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: Icon(Icons.search),
                        border: border,
                        enabledBorder: border,
                        focusedBorder: border,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                child: Placeholder(
                  color: red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
