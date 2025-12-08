import 'package:ForLetMarketplaceNG/models/dtos/login_request_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/dtos/artisan_get_dto.dart';
import '../models/dtos/artisanships_get_dto.dart';
import '../models/dtos/home_types_list_dto.dart';
import '../models/dtos/lgas_get_dto.dart';
import '../models/dtos/location_dto.dart';
import '../models/dtos/states_get_dto.dart';
import '../services/home_service.dart';

class HomeProvider extends ChangeNotifier {
  final HomeService _homeService = HomeService();
  // local storage
  final storage = const FlutterSecureStorage();
  // provider variables
  HomeTypesListDto _homeList = HomeTypesListDto();
  List<ArtisanGetDto>? _artisansList;
  List<ArtisanshipGetDto>? _artisanshipList;
  List<StateGetDto>? _stateList;
  List<LgasGetDto>? _lgaList;
  List<LgasGetDto>? _poupularPlacesList;
  final LocationDto _location = LocationDto();
  ArtisanFullGetDto _artisanFullGetDto = ArtisanFullGetDto(
    artisanServices: List<ArtisanServiceDto>.empty(),
    artisanRequests: List<ArtisanRequestDto>.empty(),
    artisanImages: List<ArtisanImageDto>.empty(),
  );
  dynamic _loginResponseDto = null;
  bool _isLoading = false;
  String? _error;

  // getters
  HomeTypesListDto get homeList => _homeList;
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<ArtisanGetDto>? get artisansList => _artisansList;
  List<ArtisanshipGetDto>? get artisanshipList => _artisanshipList;
  List<StateGetDto>? get stateList => _stateList;
  List<LgasGetDto>? get lgaList => _lgaList;
  List<LgasGetDto>? get poupularPlacesList => _poupularPlacesList;
  LocationDto? get location => _location;
  ArtisanFullGetDto get artisanFullGetDto => _artisanFullGetDto;
  dynamic get loginResponseDto => _loginResponseDto;

  // setters
  void setStateLocation(StateGetDto state) {
    location?.stateId = state.id;
    location?.stateName = state.stateName;
    // clear lga when state changes
    location?.lgaId = null;
    location?.lgaName = null;
    notifyListeners();
  }

  void setLgaLocation(LgasGetDto lga) {
    location?.lgaId = lga.id;
    location?.lgaName = lga.lgaName;
    notifyListeners();
  }

  void setLogout() async {
    // clear internal storage
    storage.deleteAll();
    // set the logged values to null
    _loginResponseDto = null;
    // notify listeners
    notifyListeners();
  }

  /////////////////////////////// methods //////////////////////////////////
  Future loadHomeList() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    // get the home list from the service
    try {
      _homeList = await _homeService.getHomeList();
    } catch (e) {
      _error = e.toString();
      print(error);
    }
    // set loading false and notify listeners
    _isLoading = false;
    notifyListeners();
  }

  Future<List<ArtisanGetDto>?> getArtisansByArtisanshipId(
      int artisanshipId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _artisansList =
          await _homeService.getArtisansByArtisanshipId(artisanshipId);
    } catch (e) {
      _error = e.toString();
      print(error);
    }

    _isLoading = false;
    notifyListeners();

    return _artisansList;
  }

  Future<List<ArtisanshipGetDto>?> getArtisanships() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _artisanshipList = await _homeService.getArtisanshipTypes();
    } catch (e) {
      _error = e.toString();
      print(error);
    }

    _isLoading = false;
    notifyListeners();

    return _artisanshipList;
  }

  Future<List<StateGetDto>?> loadStateList() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _stateList = await _homeService.getStates();
    } catch (e) {
      _error = e.toString();
      print(error);
    }

    _isLoading = false;
    notifyListeners();

    return _stateList;
  }

  Future<List<LgasGetDto>?> loadLgaList(int stateId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _lgaList = await _homeService.getLgas(stateId);
    } catch (e) {
      _error = e.toString();
      print(error);
    }

    _isLoading = false;
    notifyListeners();

    return _lgaList;
  }

  Future<List<LgasGetDto>?> loadPopularPlacesList() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _poupularPlacesList = await _homeService.getPopularPlaces();
    } catch (e) {
      _error = e.toString();
      print(error);
    }

    _isLoading = false;
    notifyListeners();

    return _poupularPlacesList;
  }

  Future<ArtisanFullGetDto> loadArtisanPreviewDetailsById(int artisanId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _artisanFullGetDto =
          await _homeService.getArtisanPreviewByArtisanId(artisanId);
    } catch (e) {
      _error = e.toString();
      print(error);
    }

    _isLoading = false;
    notifyListeners();

    return _artisanFullGetDto;
  }

  Future<dynamic> loginUser(LoginRequestDto dto) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _loginResponseDto = await _homeService.loginUser(dto);
    } catch (e) {
      _error = e.toString();
      print(error);
      _isLoading = false;
      notifyListeners();
      return null;
    }

    _isLoading = false;
    notifyListeners();

    return _loginResponseDto;
  }
}
