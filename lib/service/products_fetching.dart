import 'dart:convert';

import 'package:ewire_machine_test/model/product_model.dart';

import 'package:http/http.dart' as http;

final class ProductsFetching {
  static Future<Map<String, dynamic>> fetch() async {
    List<ProductModel> products = [];
    List<String> categoryList = [];

    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      products = data.map((e) => ProductModel.fromJson(e)).toList();

      categoryList = products.map((e) => e.category ?? '').toSet().toList();
    }

    return {'products': products, 'categories': categoryList};
  }
}
