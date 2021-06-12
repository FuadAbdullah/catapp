import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class CatPhotoAPI {
  String endpoint = 'api.thecatapi.com';
  Future<Either<Object, String>> getRandomCatPhoto() async {
    try {
      final queryParams = {"api_key": "8b2ee2ad-08f2-41e4-93db-7b61fb70a4a2"};
      final uri = Uri.https(endpoint, "v1/images/search", queryParams);
      final response = await http.get(uri);
      return Right(response.body);
    } catch (e) {
      return Left(e);
    }
  }
}
