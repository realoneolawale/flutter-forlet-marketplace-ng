import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';
import '../constants/constant.dart';
import '../constants/text_style.dart';
import '../models/dtos/lgas_get_dto.dart';
import '../models/dtos/states_get_dto.dart';
import '../provider/home_provider.dart';
import 'home_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  // screen variables
  StateGetDto? selectedState;
  LgasGetDto? selectedLga;
  // app function
  void viewHomeScreen() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<HomeProvider>(context, listen: false).loadStateList());
    Future.microtask(() => Provider.of<HomeProvider>(context, listen: false)
        .loadPopularPlacesList());
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    final states = provider.stateList ?? [];
    final lgas = provider.lgaList ?? [];
    final popularPlaces = provider.poupularPlacesList ?? [];

    return Scaffold(
      appBar: appBar,
      drawer: appDrawer(context),
      body: SafeArea(
        child: Container(
          padding: screenPadding,
          decoration: background,
          child: ListView(
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
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      'Change Location',
                      style: AppTextStyles.heading20,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      "${provider.location?.stateName ?? 'All locations'}"
                      "${provider.location?.lgaName != null ? ' >> ${provider.location?.lgaName}' : ''}",
                      style: AppTextStyles.body14,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromRGBO(225, 225, 225, 1)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<StateGetDto>(
                  value: selectedState,
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(8.0),
                  hint: Text(
                    'Select a State',
                    style: TextStyle(color: black, fontSize: 16),
                  ),
                  items: states
                      .map(
                        (state) => DropdownMenuItem<StateGetDto>(
                          value: state,
                          child: Text(state.stateName),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedState = value;
                      Provider.of<HomeProvider>(context, listen: false)
                          .loadLgaList(value?.id ?? 1);
                      // update the provider state name and id value
                      provider.setStateLocation(selectedState!);
                    });
                  },
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromRGBO(225, 225, 225, 1)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<LgasGetDto>(
                  value: selectedLga,
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(8.0),
                  hint: Text(
                    'Select an L.G.A',
                    style: TextStyle(color: black, fontSize: 16),
                  ),
                  items: lgas
                      .map(
                        (lga) => DropdownMenuItem<LgasGetDto>(
                          value: lga,
                          child: Text(lga.lgaName),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedLga = value;
                      // update the provider lga name value
                      provider.setLgaLocation(selectedLga!);
                    });
                  },
                ),
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
              SizedBox(
                height: 2.h,
              ),
              Center(
                child: Text(
                  'Popular places',
                  style: TextStyle(color: black, fontSize: 16),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              SizedBox(
                height: 60.h,
                child: GridView.builder(
                  itemCount: popularPlaces.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // <-- 2 items per row
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 3, // wider items
                  ),
                  itemBuilder: (context, index) {
                    final place = popularPlaces[index];
                    return Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: greyShade3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.location_city, color: black),
                          SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              place.lgaName,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
