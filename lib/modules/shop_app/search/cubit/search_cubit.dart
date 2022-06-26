import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/models/search_model.dart';
import 'package:news_flutter/modules/shop_app/search/cubit/search_states.dart';
import 'package:news_flutter/network/remote/dio_helper.dart';

import '../../../../constants/constants.dart';
import '../../../../network/end_points/end_points.dart';

class SearchCubit extends Cubit<SearchStates>{

  SearchCubit() : super(SearchInitialState());

 static SearchCubit get (context) => BlocProvider.of(context);

 SearchModel? model;

 void search(String text)
 {
   emit(SearchLoadingState());
   DioHelper.postData(
       url: SEARCH,
       data: {
         'text':text,
       },
     token: token,
   ).then((value) {
     model = SearchModel.fromJson(value!.data);
     emit(SearchSuccessState());
   }).catchError((error)
   {
     print(error.toString());
     emit(SearchErrorState());
   });
 }




}