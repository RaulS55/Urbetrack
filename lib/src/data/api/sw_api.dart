import 'package:urbetrack_sw/src/data/helpers/http.dart';
import 'package:urbetrack_sw/src/data/helpers/http_response.dart';
import 'package:urbetrack_sw/src/data/models/charactes.dart';
import 'package:urbetrack_sw/src/data/models/planet.dart';
import 'package:urbetrack_sw/src/data/models/starships.dart';
import 'package:urbetrack_sw/src/data/models/vehicle.dart';

class SwApi {
  final Http http;

  SwApi(this.http);

  Future<HttpResponse<Characters>> getInitialPage(String selectPage) async {
    return http.request<Characters>(
      selectPage,
      method: "GET",
      parser: (data) {
        return Characters.fromJson(data);
      },
    );
  }

  Future<HttpResponse<Planet>> getplanet(String select) async {
    return http.request<Planet>(
      select,
      method: "GET",
      parser: (data) {
        return Planet.fromJson(data);
      },
    );
  }

  Future<HttpResponse<Vehicles>> getVehicles(String select) async {
    return http.request<Vehicles>(
      select,
      method: "GET",
      parser: (data) {
        return Vehicles.fromJson(data);
      },
    );
  }

  Future<HttpResponse<Starships>> getStarships(String select) async {
    return http.request<Starships>(
      select,
      method: "GET",
      parser: (data) {
        return Starships.fromJson(data);
      },
    );
  }
}

class PostApi {
  final Http http;
  PostApi(this.http);

  Future<HttpResponse> postCharacter(
      int userId, String dateTime, String name) async {
    final vari = await http.request(
      "/posts",
      method: "POST",
      data: {"userId": userId, "dateTime": dateTime, "character_name": name},
    );
    return vari;
  }
}
