import '../models/network_responce.dart';
import '../network/api_provider.dart';

class CategoriesRepository{
  Future<NetworkResponse> getCategories() async =>
      await ApiProvider.fetchCategoriesModel();
}