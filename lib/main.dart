import 'package:flutter/material.dart';
import 'package:forlet_marketplace_ng/constants/constant.dart';
import 'package:forlet_marketplace_ng/provider/account_provider.dart';
import 'package:forlet_marketplace_ng/provider/home_provider.dart';
import 'package:forlet_marketplace_ng/screens/location_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, _, __) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => HomeProvider()),
          ChangeNotifierProvider(create: (context) => AccountProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppName,
          theme: ThemeData(),
          home: LocationScreen(),
        ),
      );
    });
  }
}
