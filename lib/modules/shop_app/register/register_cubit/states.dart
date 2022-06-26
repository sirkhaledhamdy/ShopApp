import 'package:news_flutter/models/login_model.dart';

import '../../../../models/register_model.dart';

abstract class ShopRegisterStates{}

class ShopRegisterInitialState extends ShopRegisterStates{}

class ShopRegisterLoadingState extends ShopRegisterStates{}

class ShopRegisterSuccessState extends ShopRegisterStates
{
final ShopRegisterModel? registerModel;
ShopRegisterSuccessState(this.registerModel);
}

class ShopRegisterErrorState extends ShopRegisterStates{

  final String error;
  ShopRegisterErrorState(this.error);
}
class ShopRegisterPassVisibilityState extends ShopRegisterStates{}

