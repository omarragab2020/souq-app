import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/models/shop-model/shop-app-model.dart';
import 'package:flutter_app1/modules/shop/login/cubit/states.dart';
import 'package:flutter_app1/modules/shop/register/cubit/states.dart';
import 'package:flutter_app1/shared/network/dioHelper.dart';
import 'package:flutter_app1/shared/network/end-point.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel loginModel;
  void userRegister({
    @required String email,
    @required String password,
    @required String name,
    @required String phone,
  }) {
    emit(ShopRegisterLoadingState());

    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      print('res: ' + value.data.toString());
      loginModel = ShopLoginModel.fromJson((value.data));

      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error) {
      print('error $error');
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = true;
  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown ? Icons.visibility_outlined : Icons.visibility_off;

    emit(ChangeRegisterPasswordVisibility());
  }
}
