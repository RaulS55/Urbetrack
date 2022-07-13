import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:urbetrack_sw/src/data/api/sw_api.dart';
import 'package:urbetrack_sw/src/data/models/people.dart';
import 'package:urbetrack_sw/src/ui/pages/primary_screen_page.dart';

class CharactersController extends ChangeNotifier {
  final swApi = GetIt.instance<SwApi>();

  List<People> _peoples = [];
  int _currentPage = 1;
  String _selectPage = "people/";
  String? _nextPage = "";
  String? _previousPage;
  People? _characterSelect;
  bool _swich = false;
  Widget _screen = const PrimaryScreen();

  List<People> get peoples => _peoples;
  int get currentPage => _currentPage;
  String get selectPage => _selectPage;
  String? get nextPage => _nextPage;
  String? get previousPage => _previousPage;
  People? get characterSelect => _characterSelect;
  bool get swich => _swich;
  Widget get screen => _screen;

  set peoples(List<People> value) {
    _peoples = value;
    notifyListeners();
  }

  set currentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }

  set characterSelect(People? value) {
    _characterSelect = value;
    notifyListeners();
  }

  set swich(bool value) {
    _swich = value;
    notifyListeners();
  }

  set screen(Widget value) {
    _screen = value;
    notifyListeners();
  }

  Future<List<People>> getPeoplesList(String selectPage) async {
    final response = await swApi.getInitialPage(selectPage);
    if (response.data != null) {
      final res = response.data!;
      _previousPage = res.previous?.split("api/").last;
      _nextPage = res.next?.split("api/").last;
      _peoples.clear();
      for (var element in res.results) {
        _peoples.add(element);
      }
    }
    return _peoples;
  }

  void next() {
    _selectPage = _nextPage!;
    _currentPage++;
    notifyListeners();
  }

  void previous() {
    _selectPage = _previousPage!;
    _currentPage--;
    notifyListeners();
  }

  Future<String> getElement(String element, String kind) async {
    dynamic response;
    if (kind == "vehicles") response = await swApi.getVehicles(element);
    if (kind == "starships") response = await swApi.getStarships(element);
    if (kind == "planet") response = await swApi.getplanet(element);
    if (response.data != null) {
      final res = response.data!;
      return res.name;
    }
    return "";
  }
}
