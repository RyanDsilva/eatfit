import 'package:dio/dio.dart';
import 'dart:io';

class API {
  static final String url = '';
  static BaseOptions opts = BaseOptions(
    baseUrl: url,
    responseType: ResponseType.json,
    connectTimeout: 30000,
    receiveTimeout: 30000,
  );
  static final service = Dio(opts);

  const API();

  Future<String> predictFood(File image) async {
    MultipartFile data = new MultipartFile.fromString(image.readAsStringSync());
    Response res = await service.post(
      "/predict",
      data: data,
      options: Options(
        method: 'POST',
      ),
    );
    String prediction = res.data.toString();
    return prediction;
  }

  int getCalories() {
    return 0;
  }
}
