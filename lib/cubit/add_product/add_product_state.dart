part of 'add_product_cubit.dart';

enum ProductAddStatus { ready, loading, errors }

class AddProductState {
  final ProductAddStatus status;
  final TextEditingController title;
  final TextEditingController description;
  final TextEditingController image;
  final TextEditingController price;
  final int productId;
  final Product? product;

  AddProductState._({
    this.product,
    this.productId = 0,
    this.status = ProductAddStatus.ready,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
  });

  AddProductState.init()
      : this._(
            title: TextEditingController(),
            description: TextEditingController(),
            image: TextEditingController(),
            price: TextEditingController());

  AddProductState initEdit(Product product) {
    return AddProductState._(
        product: product,
        title: TextEditingController(text: product.title),
        description: TextEditingController(text: product.description),
        image: TextEditingController(text: product.image),
        price: TextEditingController(text: product.price),
        productId: productId);
  }

  AddProductState updateProduct(int productId) {
    return AddProductState._(
        product: product,
        title: title,
        description: description,
        image: image,
        price: price,
        productId: productId,
        status: status);
  }

  AddProductState copyWith({required int productId}) {
    return AddProductState._(
        product: product,
        title: title,
        description: description,
        image: image,
        price: price,
        productId: productId);
  }
}
