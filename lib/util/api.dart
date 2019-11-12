import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:async';

class API {
  static final String url = 'https://4f5c4edb.ngrok.io';
  static BaseOptions opts = BaseOptions(
    baseUrl: url,
    responseType: ResponseType.json,
    connectTimeout: 30000,
    receiveTimeout: 30000,
  );
  static final service = Dio(opts);

  const API();

  Future<String> predictFood(File image) async {
    FormData data =
        FormData.fromMap({"file": await MultipartFile.fromFile(image.path)});
    Response res = await service.post(
      "/classify_food",
      data: data,
      options: Options(
        method: 'POST',
      ),
    );
    String prediction = res.data['result'].toString();
    return prediction;
  }
}
