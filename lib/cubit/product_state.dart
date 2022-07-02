part of 'product_cubit.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoaded extends ProductState {
  final int page;
  final int limit;
  final int total;
  final int lastPage;
  final List<Product> products;
  final bool loading;
  ProductLoaded._(
      {this.page = 1,
      this.total = 0,
      this.limit = 8,
      this.lastPage = 1,
      this.loading = false,
      required this.products});

  ProductLoaded.loaded(
      {required List<Product> products,
      int? limit,
      int? page,
      int? total,
      int? lastPage})
      : this._(
            products: products,
            total: total ?? 0,
            page: page ?? 1,
            limit: limit ?? 8,
            lastPage: lastPage ?? 1);

  ProductLoaded copyWith(
      {List<Product>? products,
      int? limit,
      int? page,
      int? total,
      int? lastPage,
      bool? loading}) {
    return ProductLoaded._(
        products: products ?? this.products,
        limit: limit ?? this.limit,
        page: page ?? this.page,
        total: total ?? this.total,
        lastPage: lastPage ?? this.lastPage,
        loading: loading ?? this.loading);
  }
}

class ProductError extends ProductState {}
