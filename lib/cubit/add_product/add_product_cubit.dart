import 'dart:convert';
import 'dart:developer';

import 'package:app_rest_api/helpers/api_helper.dart';
import 'package:app_rest_api/helpers/shared_pref.dart';
import 'package:app_rest_api/models/product.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(AddProductState.init());

  static final TextEditingController title = TextEditingController();
  static final TextEditingController description = TextEditingController();
  static final TextEditingController image = TextEditingController();
  static final TextEditingController price = TextEditingController();

  void init() {}

  void createProduct() async {
    try {
      final token = await SharedPref().getToken();
      var header = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var url = Uri.parse(ApiHelper.baseUrl + ApiHelper.createProduct);
      var request = await http.post(url, headers: header, body: {
        'title': title.text,
        'description': description.text,
        'image': image.text,
        'price': price.text
      });
      var response = jsonDecode(request.body);
      var data = response['data'];
      var product = Product.fromJson(data);
      emit(AddProductState._(
          product: product,
          title: title,
          description: description,
          image: image,
          price: price));
      var message = response['message'];
      log('Logout : $message');
    } catch (e) {
      log('Error $e');
    }
  }

  void updateProduct(int id) async {
    try {
      final token = await SharedPref().getToken();
      var header = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var url = Uri.parse(
          ApiHelper.baseUrl + ApiHelper.updateProduct + id.toString());
      var request = await http.put(url, headers: header, body: {
        'title': title.text,
        'description': description.text,
        'image': image.text,
        'price': price.text
      });
      var response = jsonDecode(request.body);
      var data = response['data'];
      var product = Product.fromJson(data);
      emit(AddProductState._(
              title: title,
              description: description,
              image: image,
              price: price,
              product: product)
          .updateProduct(id));
      var message = response['message'];
      log('resMessage : $message');
    } catch (e) {
      log('Error $e');
    }
  }

  void deleteProduct(int id) async {
    try {
      final token = await SharedPref().getToken();
      var header = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var url = Uri.parse(
          ApiHelper.baseUrl + ApiHelper.updateProduct + id.toString());
      var request = await http.put(url, headers: header, body: {
        'title': title.text,
        'description': description.text,
        'image': image.text,
        'price': price.text
      });
      var response = jsonDecode(request.body);
      var data = response['data'];
      var product = Product.fromJson(data);
      emit(AddProductState._(
              title: title,
              description: description,
              image: image,
              price: price,
              product: product)
          .updateProduct(id));
      var message = response['message'];
      log('resMessage : $message');
    } catch (e) {
      log('$e');
    }
  }
}
