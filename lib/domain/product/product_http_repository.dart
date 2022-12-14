import 'dart:convert';

import 'package:data_app/domain/http_connector.dart';
import 'package:data_app/domain/product/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final productHttpRepository = Provider<ProductHttpRepository>((ref) {
  return ProductHttpRepository(ref);
});

class ProductHttpRepository {
  Ref _ref;
  ProductHttpRepository(this._ref);

  Future<Product> findById(int id) async {
    Response response =
        await _ref.read(httpConnector).get("/api/product/${id}");
    Product product = Product.fromJson(jsonDecode(response.body));
    return product;
  }

  Future<List<Product>> findAll() async {
    Response response = await _ref.read(httpConnector).get("/api/product");
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)["data"];
      List<Product> productList = body.map((e) => Product.fromJson(e)).toList();
      return productList;
    } else {
      return [];
    }
  }

  // name, price
  Future<Product> insert(Product productReqDto) async {
    // http 통신 코드 (product 전송)
    // body
    String body = jsonEncode(productReqDto.toJson());
    Response response =
        await _ref.read(httpConnector).post("/api/product", body);
    Product product = Product.fromJson(jsonDecode(response.body)["data"]);
    return product;
  }

  Future<Product> updateById(int id, Product productReqDto) async {
    // http 통신 코드
    String body = jsonEncode(productReqDto.toJson());
    print("repository id: ${id}");
    Response response =
        await _ref.read(httpConnector).put("/api/product/${id}", body);
    Product product = Product.fromJson(jsonDecode(response.body)["data"]);
    return product;

    // final list = [].map((product) {
    //   if (product.id == id) {
    //     return productDto;
    //   } else {
    //     return product;
    //   }
    // }).toList();
    // productDto.id = id;
    // return productDto;
  }

  Future<int> deleteById(int id) async {
    // http 통신 코드
    Response response =
        await _ref.read(httpConnector).delete("/api/product/${id}");
    // 파싱해야하는데 할게 없어서 코드 파싱
    return jsonDecode(response.body)["code"]; // 1이면 성공

    // final list = [].where((product) => product.id != id).toList();
    // if (id == 4) {
    //   return -1;
    // } else {
    //   return 1;
    // }
  }
}
