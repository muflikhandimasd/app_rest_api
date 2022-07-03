import 'dart:developer';

import 'package:app_rest_api/helpers/api_helper.dart';
import 'package:app_rest_api/models/product.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../helpers/shared_pref.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  static final TextEditingController search = TextEditingController();
  static final RefreshController refreshController = RefreshController();

  void init() {
    search.text = '';
    getALlProduct();
  }

  final _query = search.text;

  void getALlProduct() async {
    try {
      int page = 1;
      int limit = 10;
      final token = await SharedPref().getToken();
      var header = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var url = Uri.parse(ApiHelper.baseUrl +
          ApiHelper.getProduct +
          '?' +
          'search=' +
          _query +
          '&limit=' +
          limit.toString() +
          '&page=' +
          page.toString());
      var request = await http.get(url, headers: header);
      final json = jsonDecode(request.body);
      if (request.statusCode == 200) {
        List data = json['data'];
        List<Product> products = data.map((e) => Product.fromJson(e)).toList();
        emit(ProductLoaded._(
          products: products,
          page: json['page'],
          limit: json['limit'],
          lastPage: json['last_page'],
          total: json['total'],
        ));
      }
    } catch (e) {
      log('Error $e');
      emit(ProductError._());
    } finally {
      refreshController.loadComplete();
    }
  }

  void onLoadMoreProduct() async {
    if (state is ProductLoaded) {
      var st = state as ProductLoaded;
      try {
        final token = await SharedPref().getToken();
        var header = {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        };
        int page = 1 + st.page;
        var url = Uri.parse(ApiHelper.baseUrl +
            ApiHelper.getProduct +
            '?' +
            'search=' +
            _query +
            '&limit=' +
            st.limit.toString() +
            '&page=' +
            page.toString());
        var request = await http.get(url, headers: header);
        var json = jsonDecode(request.body);
        if (request.statusCode == 200) {
          List listData = json['data'];
          List<Product> products =
              listData.map((e) => Product.fromJson(e)).toList();
          List oldData = st.products;
          products = [...oldData, ...products];
          emit(ProductLoaded.loaded(
            products: products,
            page: json['page'],
            limit: json['limit'],
            lastPage: json['last_page'],
            total: json['total'],
          ));
        }
      } catch (e) {
        log('Error $e');
        emit(ProductError._());
      } finally {
        refreshController.loadComplete();
      }
    }
  }

  void onRefresh() {
    getALlProduct();
  }
}
