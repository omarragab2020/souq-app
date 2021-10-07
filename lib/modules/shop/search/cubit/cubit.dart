import 'package:bloc/bloc.dart';
import 'package:flutter_app1/models/shop-model/search_model.dart';
import 'package:flutter_app1/modules/shop/search/cubit/states.dart';
import 'package:flutter_app1/shared/component/conestanse.dart';
import 'package:flutter_app1/shared/network/dioHelper.dart';
import 'package:flutter_app1/shared/network/end-point.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel model;

  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState());
      print(error.toString());
    });
  }
}
