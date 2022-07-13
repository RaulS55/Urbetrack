import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:urbetrack_sw/src/data/api/sw_api.dart';
import 'package:urbetrack_sw/src/data/helpers/http.dart';

abstract class DependencyInjection {
  static void inicialize() {
//***************API**************** */
    final Dio dio = Dio(BaseOptions(baseUrl: "https://swapi.dev/api/"));
    Http http = Http(
      dio: dio,
      logsEnabled: false,
    );
    final swApi = SwApi(http);
//***************API**************** */
    final Dio dioPost =
        Dio(BaseOptions(baseUrl: "https://jsonplaceholder.typicode.com"));
    Http httpPost = Http(
      dio: dioPost,
      logsEnabled: true,
    );
    final swApiPost = PostApi(httpPost);

    GetIt.instance.registerSingleton<SwApi>(swApi);
    GetIt.instance.registerSingleton<PostApi>(swApiPost);
  }
}
