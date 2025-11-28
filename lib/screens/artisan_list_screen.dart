import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:forlet_marketplace_ng/models/dtos/artisan_get_dto.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';
import '../constants/constant.dart';
import '../constants/text_style.dart';
import '../models/dtos/artisanships_get_dto.dart';
import '../provider/home_provider.dart';

class ArtisanListScreen extends StatefulWidget {
  ArtisanshipGetDto artisanship;
  ArtisanListScreen({super.key, required this.artisanship});

  @override
  State<ArtisanListScreen> createState() => _ArtisanListScreenState();
}

class _ArtisanListScreenState extends State<ArtisanListScreen> {
  // screen variables
  String? selectedArtisanshipNameValue;
  ArtisanshipGetDto? selectedArtisanship;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<HomeProvider>(context, listen: false)
        .getArtisansByArtisanshipId(widget.artisanship.id ?? 1));

    Future.microtask(() =>
        Provider.of<HomeProvider>(context, listen: false).getArtisanships());
  }

  @override
  Widget build(BuildContext context) {
    // initialize the provider
    final provider = Provider.of<HomeProvider>(context);
    final artisanships = provider.artisanshipList ?? [];
    final artisans = provider.artisansList ?? [];

    return Scaffold(
      appBar: appBar,
      drawer: appDrawer(context),
      body: _buildBody(provider, artisanships, artisans),
    );
  }

  Widget _buildBody(HomeProvider provider, List<ArtisanshipGetDto> artisanships,
      List<ArtisanGetDto> artisans) {
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
        child: IntrinsicHeight(
          child: Container(
            height: MediaQuery.of(context).size.height, // Force full screen
            padding: screenPadding,
            decoration: background,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.list_outlined),
                      SizedBox(
                        width: 1.w,
                      ),
                      Text(
                        '${widget.artisanship.artisanshipName} Result',
                        style: AppTextStyles.body18Bold,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 90.w,
                  child: DropdownSearch<ArtisanshipGetDto>(
                    items: artisanships,
                    itemAsString: (a) => a.artisanshipName ?? '',
                    selectedItem: selectedArtisanship,
                    popupProps: PopupProps.menu(
                      showSearchBox: true,
                      menuProps: MenuProps(
                        backgroundColor: mustard, // POPUP BACKGROUND
                      ),
                      searchFieldProps: TextFieldProps(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: greyShade3,
                          labelText: "Search artisan...",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),

                    dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                      filled: true,
                      fillColor: mustard, // MAIN COLOR
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    )),

                    // Optional: dropdown arrow color
                    dropdownButtonProps: DropdownButtonProps(
                      color: Colors.black, // arrow color
                    ),

                    onChanged: (value) {
                      setState(() {
                        selectedArtisanship = value;
                        widget.artisanship = selectedArtisanship!;
                        Provider.of<HomeProvider>(context, listen: false)
                            .getArtisansByArtisanshipId(value?.id ?? 1);
                      });
                    },
                  ),
                ),

                SizedBox(height: 2.h),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on_outlined),
                      SizedBox(
                        width: 1.w,
                      ),
                      Text(
                        '${widget.artisanship.artisanshipName} in Location',
                        style: AppTextStyles.body16,
                      ),
                    ],
                  ),
                ),
                // check if the result is empty
                artisans.isEmpty
                    ? _emptyArtisanWidget(context)
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.0, // width / height ratio
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: artisans.length,
                        itemBuilder: (_, index) {
                          final e = artisans[index];
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: black, width: 2.0),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              //height: 100.h,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: CircleAvatar(
                                      radius: 50.0,
                                      backgroundColor: mustard,
                                      backgroundImage: e.artisanImage != null
                                          ? NetworkImage(e.artisanImage!)
                                          : const AssetImage(
                                                  'assets/images/splash_screen/noimage.jpg')
                                              as ImageProvider,
                                    ),
                                  ),
                                  Text(e.artisanName ?? 'Unknown',
                                      style: AppTextStyles.body18),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.location_on_outlined,
                                          size: 18),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          e.artisanAddress ?? 'Unknown',
                                          style: AppTextStyles.body14,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                // This also ensures spacing pushes content down
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // empty artisan widget
  Widget _emptyArtisanWidget(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Illustration (replace with your own)
            Icon(
              Icons.no_accounts_outlined,
              size: 30.sp,
            ),

            const SizedBox(height: 20),

            Text(
              'No ${widget.artisanship.artisanshipName} found',
              style: AppTextStyles.body18.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Try selecting another artisanship or adjusting your search location.',
              textAlign: TextAlign.center,
              style: AppTextStyles.body14.copyWith(
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Trigger refresh
                Provider.of<HomeProvider>(context, listen: false)
                    .getArtisansByArtisanshipId(
                  selectedArtisanship?.id ?? widget.artisanship.id ?? 1,
                );
              },
              icon: const Icon(Icons.refresh),
              label: const Text(
                'Retry',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: turquoise,
                fixedSize: const Size(350, 50),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
