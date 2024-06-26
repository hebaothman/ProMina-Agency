import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:untitled/core/api/api_consumer.dart';
import 'package:untitled/core/api/http_consumer.dart';
import 'package:untitled/core/network/network_info.dart';
import 'package:untitled/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


Future<void> dependencyInjectionInit() async {
  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: InternetConnectionChecker()));
  sl.registerLazySingleton<ApiConsumer>(() => HttpConsumer(client: sl(), sharedPreferences: sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => http.Client());

}