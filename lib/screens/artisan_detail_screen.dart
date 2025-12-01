import 'dart:convert';
import 'dart:typed_data';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';
import '../constants/constant.dart';
import '../constants/text_style.dart';
import '../models/dtos/artisan_get_dto.dart';
import '../provider/home_provider.dart';
import '../services/home_service.dart';
import 'home_screen.dart';

class ArtisanDetailScreen extends StatefulWidget {
  final int artisanId;

  const ArtisanDetailScreen({super.key, required this.artisanId});

  @override
  State<ArtisanDetailScreen> createState() => _ArtisanDetailScreenState();
}

class _ArtisanDetailScreenState extends State<ArtisanDetailScreen> {
  // 1. create signal r
  late HubConnection hubConnection;
  final picker = ImagePicker();
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    // class the provide to get artisan preview details
    Future.microtask(() => Provider.of<HomeProvider>(context, listen: false)
        .loadArtisanPreviewDetailsById(widget.artisanId ?? 1));
    // 2. intialise the signalr
    initSignalR();
  }

  Future<void> initSignalR() async {
    hubConnection = HubConnectionBuilder()
        .withUrl(
          'https://forlet.com.ng/artisanchathub',
        )
        .withAutomaticReconnect()
        .build();

    hubConnection.on("ReceiveMessage", (data) {
      final msg = {
        "receiverId": data?[0],
        "message": data?[1],
        "image": data?[2],
        "date": data?[3],
      };
      setState(() => messages.add(msg));
    });

    await hubConnection.start();
    print("Connected!");
  }

  // send message
  Future<void> sendMessage(String receiverUserId, String message) async {
    await hubConnection
        .invoke("SendMessageWithFile", args: [receiverUserId, message, ""]);
  }

  // send image
  Future<void> sendImageMessage(String receiverUserId, String message) async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    final bytes = await picked.readAsBytes();
    final base64String = "data:image/png;base64,${base64Encode(bytes)}";

    await hubConnection.invoke("SendMessageWithFile",
        args: [receiverUserId, message, base64String]);
  }

  @override
  Widget build(BuildContext context) {
    // initialize the provider
    final provider = Provider.of<HomeProvider>(context);
    // get the artisans details using the getter in the provider
    final artisanFullGetDto = provider.artisanFullGetDto;

    return Scaffold(
      appBar: appBar,
      drawer: appDrawer(context),
      body: _buildBody(provider, artisanFullGetDto),
    );
  }

  Widget _buildBody(
      HomeProvider provider, ArtisanFullGetDto artisanFullGetDto) {
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
      child: Container(
        padding: screenPadding,
        decoration: background,
        child: ListView(
          children: [
            SizedBox(
              height: 2.h,
            ),
            Center(
              child: artisanFullGetDto.artisanAvatar != null
                  ? Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Image.network(
                        artisanFullGetDto.artisanAvatar!,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      'assets/images/splash_screen/noimage.jpg',
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Center(
              child: Text(
                '${artisanFullGetDto.artisanName} - ${artisanFullGetDto.artisanshipName}',
                style: AppTextStyles.heading20Bold,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            SizedBox(
              width: 90.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Location:', style: AppTextStyles.heading20Bold),
                  Text('${artisanFullGetDto.artisanAddress}',
                      style: AppTextStyles.body16),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            SizedBox(
              width: 90.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Description:', style: AppTextStyles.heading20Bold),
                  Html(data: '${artisanFullGetDto.artisanshipDescription}'),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            SizedBox(
              width: 90.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Member since:', style: AppTextStyles.heading20Bold),
                  Text(
                      HomeService.formatDate(
                          "${artisanFullGetDto.artisanCreatedDate}"),
                      style: AppTextStyles.body16),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            ExpandablePanel(
              header: Text(
                "Services offered & pricing",
                style: AppTextStyles.heading20Bold,
              ),
              collapsed: Text(
                "Tap to expand and see more details...",
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              expanded: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  if (artisanFullGetDto.artisanServices.isNotEmpty)
                    ...artisanFullGetDto.artisanServices.map(
                      (e) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e.services.toString(), softWrap: true),
                          Text("From ₦${e.price.toStringAsFixed(2)}"),
                          SizedBox(height: 8),
                        ],
                      ),
                    )
                  else
                    Text("No service found"),
                ],
              ),
              theme: ExpandableThemeData(
                iconColor: Colors.blue,
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                tapBodyToExpand: true,
                tapBodyToCollapse: true,
                hasIcon: true,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            ExpandablePanel(
              header: Text(
                "${artisanFullGetDto.artisanName}'s services & description",
                style: AppTextStyles.heading20Bold,
              ),
              collapsed: Text(
                "Tap to expand and see more details...",
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              expanded: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  if (artisanFullGetDto.artisanImages.isNotEmpty)
                    ...artisanFullGetDto.artisanImages.map(
                      (e) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image widget instead of Container with ImageProvider
                          Container(
                            child: e.artisanImageUrl != null
                                ? Image.network(
                                    e.artisanImageUrl!,
                                    height: 150, // optional: set a size
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/images/splash_screen/noimage.jpg',
                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            e.artisanImageName.toString(),
                            softWrap: true,
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    )
                  else
                    Text("No service found"),
                ],
              ),
              theme: ExpandableThemeData(
                iconColor: Colors.blue,
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                tapBodyToExpand: true,
                tapBodyToCollapse: true,
                hasIcon: true,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            ExpandablePanel(
              header: Text(
                "${artisanFullGetDto.artisanName}'s reviews & ratings",
                style: AppTextStyles.heading20Bold,
              ),
              collapsed: Text(
                "Tap to expand and see more details...",
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              expanded: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Here is the expanded content. "
                    "You can put any widget you want here.",
                    softWrap: true,
                  ),
                  SizedBox(height: 10),
                  Text("• Bullet point 1"),
                  Text("• Bullet point 2"),
                  Text("• Bullet point 3"),
                ],
              ),
              theme: ExpandableThemeData(
                iconColor: Colors.blue,
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                tapBodyToExpand: true,
                tapBodyToCollapse: true,
                hasIcon: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  // GO TO COMPLETE DETAILS SCREEN AND CHAT USING SIGNALR
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: turquoise,
                  //minimumSize: const Size(double.infinity, 50),
                  fixedSize: const Size(350, 50),
                ),
                child: const Text(
                  'View Contact Details & Chat 💬',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            // Chat Section
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: messages.isNotEmpty
                  ? messages.map((msg) {
                      Uint8List? imgBytes;
                      if (msg["image"] != null && msg["image"] != "") {
                        imgBytes = base64Decode(msg["image"].split(',').last)
                            as Uint8List?;
                      }
                      return ListTile(
                        title: Text(msg["message"]),
                        subtitle: Text(msg["date"]),
                        trailing: imgBytes != null
                            ? Image.memory(imgBytes, width: 100)
                            : null,
                      );
                    }).toList()
                  : [
                      Center(
                        child: Text(
                          '💬...',
                          style: AppTextStyles.body14,
                        ),
                      ),
                    ],
            ),
          ],
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
              'Artisan not found',
              style: AppTextStyles.body18.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Try selecting another artisan or adjusting your search location.',
              textAlign: TextAlign.center,
              style: AppTextStyles.body14.copyWith(
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Trigger refresh
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (route) => false);
              },
              icon: const Icon(Icons.home_outlined),
              label: const Text(
                'Go Back Home',
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
