import 'package:news_flutter/models/login_model.dart';

abstract class ShopLoginStates{}

class ShopLoginInitialState extends ShopLoginStates{}

class ShopLoginLoadingState extends ShopLoginStates{}

class ShopLoginsSuccessState extends ShopLoginStates
{
final ShopLoginModel? loginModel;
ShopLoginsSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginStates{

  final String error;
  ShopLoginErrorState(this.error);
}
class ShopchangePassVisibilityState extends ShopLoginStates{}

