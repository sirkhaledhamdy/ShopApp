
import 'package:news_flutter/models/profile_model.dart';

import '../models/change_favourite_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates{}

class ShopBottomNavState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{}

class ShopSuccessCategoryDataState extends ShopStates{}

class ShopErrorCategoryDataState extends ShopStates{}

class ShopSuccessFavouriteDataState extends ShopStates{

  final FavouriteModel model;

  ShopSuccessFavouriteDataState(this.model);
}

class ShopSuccessFavouriteDListenerState extends ShopStates{}

class ShopErrorFavouriteDataState extends ShopStates{}

class ShopLoadingAddFavouriteDataState extends ShopStates{}

class ShopSuccessAddFavouriteDataState extends ShopStates{
}

class ShopErrorAddFavouriteDataState extends ShopStates{}

class ShopLoadingAddProfileDataState extends ShopStates{}

class ShopSuccessAddProfileDataState extends ShopStates
{
  final ProfileModel ? userModel;

  ShopSuccessAddProfileDataState(this.userModel);
}

class ShopErrorAddProfileDataState extends ShopStates{}

class ShopLoadingUpdateProfileDataState extends ShopStates{}

class ShopSuccessUpdateProfileDataState extends ShopStates
{
  final ProfileModel ? userModel;

  ShopSuccessUpdateProfileDataState(this.userModel);
}

class ShopErrorUpdateProfileDataState extends ShopStates{}




