import 'package:flutter/material.dart';
import 'package:forlet_marketplace_ng/models/dtos/home_types_list_dto.dart';
import 'package:forlet_marketplace_ng/models/dtos/lgas_get_dto.dart';
import 'package:forlet_marketplace_ng/models/dtos/states_get_dto.dart';
import 'package:forlet_marketplace_ng/services/home_service.dart';

import '../models/dtos/artisan_get_dto.dart';
import '../models/dtos/artisanships_get_dto.dart';
import '../models/dtos/location_dto.dart';

class HomeProvider extends ChangeNotifier {
  final HomeService _homeService = HomeService();

  HomeTypesListDto _homeList = HomeTypesListDto();
  List<ArtisanGetDto>? _artisansList;
  List<ArtisanshipGetDto>? _artisanshipList;
  List<StateGetDto>? _stateList;
  List<LgasGetDto>? _lgaList;
  LocationDto _location = LocationDto();
  bool _isLoading = false;
  String? _error;

  HomeTypesListDto get homeList => _homeList;
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<ArtisanGetDto>? get artisansList => _artisansList;
  List<ArtisanshipGetDto>? get artisanshipList => _artisanshipList;
  List<StateGetDto>? get stateList => _stateList;
  List<LgasGetDto>? get lgaList => _lgaList;
  LocationDto? get location => _location;

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
}
