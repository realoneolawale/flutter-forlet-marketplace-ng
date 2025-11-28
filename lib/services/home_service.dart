import 'dart:convert';
import 'dart:io';

import 'package:forlet_marketplace_ng/models/dtos/artisan_get_dto.dart';
import 'package:forlet_marketplace_ng/models/dtos/artisanships_get_dto.dart';
import 'package:forlet_marketplace_ng/models/dtos/home_types_list_dto.dart';
import 'package:forlet_marketplace_ng/models/dtos/lgas_get_dto.dart';
import 'package:forlet_marketplace_ng/models/dtos/states_get_dto.dart';
import 'package:http/http.dart' as http;

class HomeService {
  late String baseUrl;
  final headers = {'X-Country': 'NG'};
  HomeService() {
    if (Platform.isAndroid) {
      baseUrl = "http://10.0.2.2:5000";
    } else if (Platform.isIOS) {
      baseUrl = "http://127.0.0.1:5000";
    }
  }

  // get home list
  Future<HomeTypesListDto> getHomeList() async {
    final response = await http.get(Uri.parse("$baseUrl/api/home/get-home"),
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
    final response = await http.get(
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
    final response = await http.get(
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
    final response = await http.get(Uri.parse("$baseUrl/api/home/get-states"),
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
    final response = await http.get(
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
}
