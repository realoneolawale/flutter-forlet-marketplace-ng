import 'package:ForLetMarketplaceNG/provider/account_provider.dart';
import 'package:ForLetMarketplaceNG/provider/home_provider.dart';
import 'package:ForLetMarketplaceNG/screens/artisan_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'constants/constant.dart';

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
          home: ArtisanDetailScreen(artisanId: 17),
        ),
      );
    });
  }
}
