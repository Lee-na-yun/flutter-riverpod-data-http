import 'package:data_app/domain/product/product.dart';
import 'package:data_app/domain/product/product_http_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productListViewModel =
    StateNotifierProvider<ProductListViewModel, List<Product>>((ref) {
  return ProductListViewModel([], ref)
    ..initViewModel(); //초기화는 []과 ref ..cascade
});

class ProductListViewModel extends StateNotifier<List<Product>> {
  Ref _ref; // ref를 받고
  ProductListViewModel(super.state, this._ref); // 상태에 []

  void initViewModel() async {
    // view모델을 초기화하는 메서드
    print("실행됨");
    List<Product> products = await _ref.read(productHttpRepository).findAll();
    state = products;
  }

  void refresh(List<Product> productsDto) {
    state = productsDto;
  }

  void addProduct(Product productRespDto) {
    state = [...state, productRespDto];
  }

  void removeProduct(int id) {
    state = state.where((product) => product.id != id).toList();
  }

  void updateProduct(Product productRespDto) {
    state = state.map((product) {
      if (product.id == productRespDto.id) {
        return productRespDto;
      } else {
        return product;
      }
    }).toList();
  }
}
