import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/dtos/artisan_get_dto.dart';
import '../models/dtos/artisanships_get_dto.dart';
import '../models/dtos/home_types_list_dto.dart';
import '../models/dtos/lgas_get_dto.dart';
import '../models/dtos/login_request_dto.dart';
import '../models/dtos/login_response_dto.dart';
import '../models/dtos/states_get_dto.dart';

class HomeService {
  late String baseUrl;
  final headers = {'X-Country': 'NG'};
  final storage = const FlutterSecureStorage();
  // forces on instance of http that closes after every connection to avoid socket exhaustion
  static final http.Client client = http.Client();

  HomeService() {
    // test on emulators
    // if (Platform.isAndroid) {
    //   baseUrl = "http://10.0.2.2:5000";
    // } else if (Platform.isIOS) {
    //   baseUrl = "http://127.0.0.1:5000";
    // }
    // testing on physical device
    baseUrl = "http://192.168.0.175:5000";
  }

  // get home list
  Future<HomeTypesListDto> getHomeList() async {
    final response = await client.get(Uri.parse("$baseUrl/api/home/get-home"),
        headers: headers);
    //print(response.body);
    if (response.statusCode != 200) {
      throw Exception("Failed to load home list");
    }
    return HomeTypesListDto.fromJson(json.decode(response.body));
  }

  // get artisans by artisanship id
  Future<List<ArtisanGetDto>> getArtisansByArtisanshipId(
      int artisanshipId) async {
    final response = await client.get(
        Uri.parse(
            "$baseUrl/api/home/get-artisans-by-artisanship-id/$artisanshipId"),
        headers: headers);
    //print(response.body);
    if (response.statusCode != 200) {
      throw Exception("Failed to load home list");
    }
    // create DTO from Map
    List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
    return jsonList.map((json) => ArtisanGetDto.fromJson(json)).toList();
  }

  // get artisanship types
  Future<List<ArtisanshipGetDto>> getArtisanshipTypes() async {
    final response = await client.get(
        Uri.parse("$baseUrl/api/home/get-artisanship-types"),
        headers: headers);
    //print(response.body);
    if (response.statusCode != 200) {
      throw Exception("Failed to load home list");
    }
    // create DTO from Map
    List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
    return jsonList.map((json) => ArtisanshipGetDto.fromJson(json)).toList();
  }

  // get states
  Future<List<StateGetDto>> getStates() async {
    final response = await client.get(Uri.parse("$baseUrl/api/home/get-states"),
        headers: headers);
    //print(response.body);
    if (response.statusCode != 200) {
      throw Exception("Failed to load home list");
    }
    // create DTO from Map
    List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
    return jsonList.map((json) => StateGetDto.fromJson(json)).toList();
  }

  // get getlgas
  Future<List<LgasGetDto>> getLgas(int stateId) async {
    final response = await client.get(
        Uri.parse("$baseUrl/api/home/get-lgas/$stateId"),
        headers: headers);
    //print(response.body);
    if (response.statusCode != 200) {
      throw Exception("Failed to load home list");
    }
    // create DTO from Map
    List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
    return jsonList.map((json) => LgasGetDto.fromJson(json)).toList();
  }

  Future<List<LgasGetDto>> getPopularPlaces() async {
    final response = await client.get(
        Uri.parse("$baseUrl/api/home/get-popular-places"),
        headers: headers);
    //print(response.body);
    if (response.statusCode != 200) {
      throw Exception("Failed to load home list");
    }
    // create DTO from Map
    List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
    return jsonList.map((json) => LgasGetDto.fromJson(json)).toList();
  }

  // refresh token
  Future<dynamic> refreshToken(LoginRequestDto dto) async {
    // method will be called when an authorized endpoint hit 401 authorized
    String? token = await storage.read(key: 'accessToken');
    String? refresh = await storage.read(key: 'refreshToken');

    final refreshTokenRequestBody = jsonEncode({
      'token': token,
      'refreshToken': refresh,
    });

    final response = await client.post(Uri.parse("$baseUrl/api/auth/refresh"),
        headers: headers, body: refreshTokenRequestBody);
    LoginResponseDto result =
        LoginResponseDto.fromJson(json.decode(response.body));
    // save the token in secure storage
    await saveLoginTokens(result.token, result.refreshToken);
    return result;
  }

  // login user
  Future<dynamic> loginUser(LoginRequestDto dto) async {
    final body = jsonEncode({
      'username': dto.username,
      'password': dto.password,
    });

    final response = await client.post(Uri.parse("$baseUrl/api/auth/login"),
        headers: headers, body: body);

    if (response.statusCode == 200) {
      LoginResponseDto result =
          LoginResponseDto.fromJson(json.decode(response.body));
      // store tokens in secureStorage
      await saveLoginTokens(result.token, result.refreshToken);
      return result;
    }
    // create DTO from Map
    return null;
  }

  Future<void> saveLoginTokens(String accessToken, String refreshToken) async {
    await storage.write(key: 'accessToken', value: accessToken);
    await storage.write(key: 'refreshToken', value: refreshToken);
  }

  Future<ArtisanFullGetDto> getArtisanPreviewByArtisanId(int artisanId) async {
    final response = await client.get(
        Uri.parse("$baseUrl/api/home/get-artisan-preview-by-id/$artisanId"),
        headers: headers);
    //print("RESPONSE: ${response.body}");
    if (response.statusCode != 200) {
      throw Exception("Failed to artisan details");
    }
    return ArtisanFullGetDto.fromJson(json.decode(response.body));
  }

  static String formatDate(String rawDate) {
    final date = DateTime.parse(rawDate);
    return DateFormat('MMMM yyyy').format(date);
  }
}
