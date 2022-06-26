import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/modules/shop_app/login/cubit/states.dart';
import 'package:news_flutter/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import '../../../../models/login_model.dart';
import '../../../../network/end_points/end_points.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());



  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;

  void userLogin({
    @required String? email,
    @required String? password,
  }) {

    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value?.data);
      loginModel = ShopLoginModel.fromJson(value?.data);
      emit(ShopLoginsSuccessState(loginModel));
    }).catchError((error){
      print(error);
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility;
  bool isPassShown = true;

  void changePassVisibility ()
  {
    isPassShown = !isPassShown;
    suffix = isPassShown == true ? Icons.visibility: Icons.visibility_off;
    emit(ShopchangePassVisibilityState());
  }
}
