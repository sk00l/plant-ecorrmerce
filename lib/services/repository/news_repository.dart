import 'package:dio/dio.dart';
import 'package:plant_ecommerce/configs/api/api_endpoints.dart';
import 'package:plant_ecommerce/configs/di/service_locator.dart';
import 'package:plant_ecommerce/services/repository/news_model.dart';

class NewsRepository {
  Future<NewsModel?> getNews() async {
    try {
      final response = await dio.get(
        ApiEndpoints.everyNews,
        queryParameters: {
          "q": "bitcoin",
          "pageSize": 2,
          "apiKey": "19f5064aeabb4603a859da738df6bd6a"
        },
      );
      if (response.statusCode == 200) {
        return NewsModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print("error:::======== $e");
    }
    return null;
  }

  Dio dio = getIt.get<Dio>();
}
