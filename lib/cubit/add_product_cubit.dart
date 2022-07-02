import 'dart:convert';

import 'package:app_rest_api/helpers/api_helper.dart';
import 'package:app_rest_api/helpers/shared_pref.dart';
import 'package:app_rest_api/models/product.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit({this.id, this.product}) : super(AddProductState.init());

  final Product? product;
  final int? id;
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

  void init() {}

  void createProduct() {}
  void updateProduct() {}
  void deleteProduct() {}
}
