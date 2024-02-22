import 'dart:convert';
import 'package:http/http.dart'as http;
import '../models/categories/categories.dart';
import '../models/network_responce.dart';
import '../models/product/product.dart';

class ApiProvider {
  static Future<NetworkResponse> fetchProductModel(int id) async {
    NetworkResponse networkResponse = NetworkResponse();
    try {
      http.Response response = await http
          .get(Uri.parse("https://imtixon.free.mockoapp.net/categories/$id"));

      if (response.statusCode == 200) {
        networkResponse.data = (jsonDecode(response.body) as List?)
            ?.map((e) => ProductModel.fromJson(e))
            .toList() ??
            [];
      } else {
        networkResponse.errorText = "Internal error";
      }
    } catch (error) {
      networkResponse.errorText = error.toString();
    }

    return networkResponse;
  }
  static Future<NetworkResponse> fetchCategoriesModel() async {
    NetworkResponse networkResponse = NetworkResponse();
    try {
      http.Response response = await http
          .get(Uri.parse("https://imtixon.free.mockoapp.net/categories"));

      if (response.statusCode == 200) {
        networkResponse.data = (jsonDecode(response.body) as List?)
            ?.map((e) => CategoriesModel.fromJson(e))
            .toList() ??
            [];
      } else {
        networkResponse.errorText = "Internal error";
      }
    } catch (error) {
      networkResponse.errorText = error.toString();
    }

    return networkResponse;
  }


}
