import 'package:flutter/material.dart';

import '../models/network_responce.dart';
import '../network/api_provider.dart';

class ProductRepository{
  Future<NetworkResponse> getCountries(int id) async =>
      await ApiProvider.fetchProductModel(id);
}