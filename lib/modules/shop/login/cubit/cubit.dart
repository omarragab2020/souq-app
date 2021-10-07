import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/models/shop-model/shop-app-model.dart';
import 'package:flutter_app1/modules/shop/login/cubit/states.dart';
import 'package:flutter_app1/shared/network/dioHelper.dart';
import 'package:flutter_app1/shared/network/end-point.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginState> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel loginModel;
  void userLogin({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  }) {
    emit(ShopLoginLoadingState());

    DioHelper.postData(url: REGISTER, data: {
      'name': email,
      'email': email,
      'password': email,
      'phone': password,
    }).then((value) {
      print('res: ' + value.data.toString());
      loginModel = ShopLoginModel.fromJson((value.data));

      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      print('error $error');
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = true;
  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown ? Icons.visibility_outlined : Icons.visibility_off;

    emit(ChangePasswordVisibility());
  }
}
