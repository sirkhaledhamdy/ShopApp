import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/modules/shop_app/register/register_cubit/states.dart';
import 'package:news_flutter/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import '../../../../models/register_model.dart';
import '../../../../network/end_points/end_points.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());



  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopRegisterModel? registerModel;

  void userRegister({
    @required String? email,
    @required String? password,
    @required String? name,
    @required String? phone,
  }) {

    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      registerModel = ShopRegisterModel.fromJson(value?.data);
      emit(ShopRegisterSuccessState(registerModel));
    }).catchError((error){
      print(error);
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility;
  bool isPassShown = true;

  void changePassVisibility ()
  {
    isPassShown = !isPassShown;
    suffix = isPassShown == true ? Icons.visibility: Icons.visibility_off;
    emit(ShopRegisterPassVisibilityState());
  }

}
