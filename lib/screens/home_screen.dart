import 'package:flutter/material.dart';
import 'package:forlet_marketplace_ng/constants/colors.dart';
import 'package:forlet_marketplace_ng/constants/constant.dart';
import 'package:forlet_marketplace_ng/constants/text_style.dart';
import 'package:forlet_marketplace_ng/models/dtos/artisanships_get_dto.dart';
import 'package:forlet_marketplace_ng/provider/home_provider.dart';
import 'package:forlet_marketplace_ng/screens/artisan_list_screen.dart';
import 'package:forlet_marketplace_ng/screens/location_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // app variables
  int? intSelectedArtisanshipId;
  int? intSelectedHousingTypeId;
  int? intSelectedCommunityTypeId;
  int? intSelectedSaleTypeId;
  int? intSelectedServiceTypeId;
  int? intSelectedJobTypeId;
  int? intSelectedDiscussionTypeId;
  int? intSelectedPersonalTypeId;
  int? intSelectedGigTypeId;

  // app functions
  void viewLocationScreen() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LocationScreen()),
        (route) => false);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<HomeProvider>(context, listen: false).loadHomeList());
  }

  @override
  Widget build(BuildContext context) {
    // initialize the provider
    final provider = Provider.of<HomeProvider>(context);

    return Scaffold(
      appBar: appBar,
      drawer: appDrawer(context),
      body: _buildBody(provider),
    );
  }

  Widget _buildBody(HomeProvider provider) {
    if (provider.isLoading) {
      return IntrinsicHeight(
        child: Container(
          height: MediaQuery.of(context).size.height, // Force full screen
          padding: screenPadding,
          decoration: background,
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (provider.error != null) {
      return IntrinsicHeight(
        child: Container(
          height: MediaQuery.of(context).size.height, // Force full screen
          padding: screenPadding,
          decoration: background,
          child: Center(child: Text("Error: ${provider.error}")),
        ),
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: screenPadding,
          decoration: background,
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good Morning",
                        style: AppTextStyles.body16,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        "Charlton Uwa",
                        style: AppTextStyles.body18Bold,
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 50.0,
                    backgroundColor: mustard,
                    backgroundImage:
                        AssetImage('assets/images/splash_screen/wale.jpg'),
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              SizedBox(
                width: 90.w,
                child: InkWell(
                  onTap: viewLocationScreen,
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.location_on_outlined),
                        Text(
                          "${provider.location?.stateName ?? 'All locations'}"
                          "${provider.location?.lgaName != null ? ' >> ${provider.location!.lgaName}' : ''}",
                          style: AppTextStyles.body14,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              const SizedBox(
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
              SizedBox(
                height: 2.h,
              ),
              // Artisans Card
              SizedBox(
                width: 90.w,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: black,
                      width: 1,
                    ),
                    color: transparent,
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(8.0),
                        right: Radius.circular(8.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width:
                            double.infinity, // makes the container full width
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(8.0),
                            right: Radius.circular(8.0),
                          ),
                          color: mustard,
                        ), // background color
                        padding: EdgeInsets.all(8),
                        child: Text(
                          '👷🏾Artisan 👷',
                          style: AppTextStyles.heading20
                              .copyWith(backgroundColor: mustard),
                        ),
                      ),
                      GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 8,
                        shrinkWrap: true,
                        physics:
                            NeverScrollableScrollPhysics(), // optionally adjust height
                        children: provider.homeList.artisanshipTypes?.map((e) {
                              return InkWell(
                                child: Text(e.name),
                                onTap: () {
                                  intSelectedArtisanshipId = e.id;
                                  ArtisanshipGetDto artisanship =
                                      ArtisanshipGetDto(
                                          id: e.id, artisanshipName: e.name);
                                  print("ID: ${e.id} NAME: ${e.name}");

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ArtisanListScreen(
                                          artisanship: artisanship),
                                    ),
                                  );
                                },
                              );
                            }).toList() ??
                            [Center(child: const Text('No data'))],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              // community
              SizedBox(
                width: 90.w,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: black,
                      width: 1,
                    ),
                    color: transparent,
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(8.0),
                        right: Radius.circular(8.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width:
                            double.infinity, // makes the container full width
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(8.0),
                            right: Radius.circular(8.0),
                          ),
                          color: mustard,
                        ), // background color
                        padding: EdgeInsets.all(8),
                        child: Text(
                          '👬Community 👬',
                          style: AppTextStyles.heading20
                              .copyWith(backgroundColor: mustard),
                        ),
                      ),
                      GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 8,
                        shrinkWrap: true,
                        physics:
                            NeverScrollableScrollPhysics(), // optionally adjust height
                        children: provider.homeList.communityTypes?.map((e) {
                              return InkWell(child: Text(e.name));
                            }).toList() ??
                            [Center(child: const Text('No data'))],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              // Housing
              SizedBox(
                width: 90.w,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: black,
                      width: 1,
                    ),
                    color: transparent,
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(8.0),
                        right: Radius.circular(8.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width:
                            double.infinity, // makes the container full width
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(8.0),
                            right: Radius.circular(8.0),
                          ),
                          color: mustard,
                        ), // background color
                        padding: EdgeInsets.all(8),
                        child: Text(
                          '🏠Housing For Rent 🏠',
                          style: AppTextStyles.heading20
                              .copyWith(backgroundColor: mustard),
                        ),
                      ),
                      GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 8,
                        shrinkWrap: true,
                        physics:
                            NeverScrollableScrollPhysics(), // optionally adjust height
                        children: provider.homeList.housingTypes?.map((e) {
                              return InkWell(child: Text(e.name));
                            }).toList() ??
                            [Center(child: const Text('No data'))],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              // Jobs
              SizedBox(
                width: 90.w,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: black,
                      width: 1,
                    ),
                    color: transparent,
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(8.0),
                        right: Radius.circular(8.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width:
                            double.infinity, // makes the container full width
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(8.0),
                            right: Radius.circular(8.0),
                          ),
                          color: mustard,
                        ), // background color
                        padding: EdgeInsets.all(8),
                        child: Text(
                          '🛠 Jobs 🛠',
                          style: AppTextStyles.heading20
                              .copyWith(backgroundColor: mustard),
                        ),
                      ),
                      GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 8,
                        shrinkWrap: true,
                        physics:
                            NeverScrollableScrollPhysics(), // optionally adjust height
                        children: provider.homeList.jobTypes?.map((e) {
                              return InkWell(child: Text(e.name));
                            }).toList() ??
                            [Center(child: const Text('No data'))],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              // For Sale
              SizedBox(
                width: 90.w,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: black,
                      width: 1,
                    ),
                    color: transparent,
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(8.0),
                        right: Radius.circular(8.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width:
                            double.infinity, // makes the container full width
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(8.0),
                            right: Radius.circular(8.0),
                          ),
                          color: mustard,
                        ), // background color
                        padding: EdgeInsets.all(8),
                        child: Text(
                          '💰For Sale 💰',
                          style: AppTextStyles.heading20
                              .copyWith(backgroundColor: mustard),
                        ),
                      ),
                      GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 8,
                        shrinkWrap: true,
                        physics:
                            NeverScrollableScrollPhysics(), // optionally adjust height
                        children: provider.homeList.saleTypes?.map((e) {
                              return InkWell(child: Text(e.name));
                            }).toList() ??
                            [Center(child: const Text('No data'))],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              // General Services
              SizedBox(
                width: 90.w,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: black,
                      width: 1,
                    ),
                    color: transparent,
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(8.0),
                        right: Radius.circular(8.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width:
                            double.infinity, // makes the container full width
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(8.0),
                            right: Radius.circular(8.0),
                          ),
                          color: mustard,
                        ), // background color
                        padding: EdgeInsets.all(8),
                        child: Text(
                          '🔧 General Services 🔧',
                          style: AppTextStyles.heading20
                              .copyWith(backgroundColor: mustard),
                        ),
                      ),
                      GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 8,
                        shrinkWrap: true,
                        physics:
                            NeverScrollableScrollPhysics(), // optionally adjust height
                        children:
                            provider.homeList.generalServiceTypes?.map((e) {
                                  return InkWell(child: Text(e.name));
                                }).toList() ??
                                [Center(child: const Text('No data'))],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              // Discussion Forum
              SizedBox(
                width: 90.w,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: black,
                      width: 1,
                    ),
                    color: transparent,
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(8.0),
                        right: Radius.circular(8.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width:
                            double.infinity, // makes the container full width
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(8.0),
                            right: Radius.circular(8.0),
                          ),
                          color: mustard,
                        ), // background color
                        padding: EdgeInsets.all(8),
                        child: Text(
                          '🗣Discussion Forum 🗣',
                          style: AppTextStyles.heading20
                              .copyWith(backgroundColor: mustard),
                        ),
                      ),
                      GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 8,
                        shrinkWrap: true,
                        physics:
                            NeverScrollableScrollPhysics(), // optionally adjust height
                        children: provider.homeList.discussionTypes?.map((e) {
                              return InkWell(child: Text(e.name));
                            }).toList() ??
                            [Center(child: const Text('No data'))],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              // Gigs/quick jobs
              SizedBox(
                width: 90.w,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: black,
                      width: 1,
                    ),
                    color: transparent,
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(8.0),
                        right: Radius.circular(8.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width:
                            double.infinity, // makes the container full width
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(8.0),
                            right: Radius.circular(8.0),
                          ),
                          color: mustard,
                        ), // background color
                        padding: EdgeInsets.all(8),
                        child: Text(
                          '🛠 Gigs/quick jobs 🛠',
                          style: AppTextStyles.heading20
                              .copyWith(backgroundColor: mustard),
                        ),
                      ),
                      GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 8,
                        shrinkWrap: true,
                        physics:
                            NeverScrollableScrollPhysics(), // optionally adjust height
                        children: provider.homeList.gigTypes?.map((e) {
                              return InkWell(child: Text(e.name));
                            }).toList() ??
                            [Center(child: const Text('No data'))],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              // Personals
              SizedBox(
                width: 90.w,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: black,
                      width: 1,
                    ),
                    color: transparent,
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(8.0),
                        right: Radius.circular(8.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width:
                            double.infinity, // makes the container full width
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(8.0),
                            right: Radius.circular(8.0),
                          ),
                          color: mustard,
                        ), // background color
                        padding: EdgeInsets.all(8),
                        child: Text(
                          '💖 Personals 💖',
                          style: AppTextStyles.heading20
                              .copyWith(backgroundColor: mustard),
                        ),
                      ),
                      GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 8,
                        shrinkWrap: true,
                        physics:
                            NeverScrollableScrollPhysics(), // optionally adjust height
                        children: provider.homeList.personalTypes?.map((e) {
                              return InkWell(child: Text(e.name));
                            }).toList() ??
                            [Center(child: const Text('No data'))],
                      ),
                    ],
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
