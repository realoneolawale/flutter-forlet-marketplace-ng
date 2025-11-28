import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../constants/constant.dart';
import '../constants/text_style.dart';
import '../provider/home_provider.dart';

class ArtisanDetailScreen extends StatefulWidget {
  const ArtisanDetailScreen({super.key});

  @override
  State<ArtisanDetailScreen> createState() => _ArtisanDetailScreenState();
}

class _ArtisanDetailScreenState extends State<ArtisanDetailScreen> {
  @override
  Widget build(BuildContext context) {
    // initialize the provider
    final provider = Provider.of<HomeProvider>(context);

    return Scaffold(
      appBar: appBar,
      drawer: appDrawer(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: screenPadding,
            decoration: background,
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: TextField(
                        //onChanged: () {},
                        decoration: InputDecoration(
                          hintText: 'Search artisan...',
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
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'John Doe - Mechanic',
                          style: AppTextStyles.body16,
                        ),
                        Expanded(
                          child: Placeholder(
                            color: Colors.red,
                          ),
                        ),
                      ],
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
