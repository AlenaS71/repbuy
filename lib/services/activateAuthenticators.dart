import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:shapmanpaypoint/controller/Loader/loader_controller.dart';
import 'package:shapmanpaypoint/services/operatorsService.dart';

import 'package:shapmanpaypoint/utils/Getters/base_url.dart';

class AirtimeAuth {
  static BaseOptions options = BaseOptions(
    baseUrl: Constants.base_url,
    connectTimeout: Duration(minutes: 3),
    receiveTimeout: Duration(minutes: 3),
  );
  final Dio dio = Dio(options);
  final loaderController = Get.put(LoaderController());
  final fetchOperator = FetchOperatorService();
  Future<Response<dynamic>> activator() async {
    try {
      loaderController.isLoading.value = true;
      final response = await dio.post('/authtopup', options: Options());

      if (response.data == "successfully") {
        loaderController.isLoading.value = false;
        fetchOperator.operators();
        print(response);
      } else {
        loaderController.isLoading.value = true;
      }
      return response;
    } catch (error) {
      loaderController.isLoading.value = true;
      rethrow;
    }
  }
}