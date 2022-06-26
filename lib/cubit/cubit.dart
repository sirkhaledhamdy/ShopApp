import 'package:flutter/material.dart';
import 'package:news_flutter/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/models/categories_model.dart';
import 'package:news_flutter/models/home_model.dart';
import 'package:news_flutter/modules/categories/shop_categories_screen.dart';
import 'package:news_flutter/modules/shop_app/favourite/shop_favourite_screen.dart';
import 'package:news_flutter/modules/shop_app/products/shop_products_screen.dart';
import 'package:news_flutter/modules/shop_app/settings/shop_settings_screen.dart';
import 'package:news_flutter/network/end_points/end_points.dart';
import 'package:news_flutter/network/remote/dio_helper.dart';

import '../constants/constants.dart';
import '../models/change_favourite_model.dart';
import '../models/add_favourite_model.dart';
import '../models/profile_model.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    ShopProductScreen(),
    ShopCategoriesScreen(),
    ShopFavouriteScreen(),
    ShopSettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopBottomNavState());
  }

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
      ),
      label: 'Products',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.favorite,
      ),
      label: 'Favorites',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'Settings',
    ),
  ];

  HomeModel? homeData;
  Map<int?, bool?> favourites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      token: token,
      url: HOME,
    ).then((value)
    {
      homeData = HomeModel.fromJson(value!.data);
      print(homeData?.status);
      homeData!.data!.products.forEach((element)
      {
      favourites.addAll({
        element.id : element.inFavorites
      });
      });

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }



  CategoriesModel? categoriesModel;

  void getCategoryData()
  {
    DioHelper.getData(
      lang: 'en',
      url: GET_CATEGORIES,
    ).then((value)
    {
      categoriesModel = CategoriesModel.fromJson(value!.data);

      emit(ShopSuccessCategoryDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoryDataState());
    });
  }


  FavouriteModel? favouriteModel;

  void postFavouriteData(int? productId)
  {
    if(favourites[productId] == true) {
      favourites[productId] = false ;
    }else{
      favourites[productId] = true ;
    }
    emit(ShopSuccessFavouriteDListenerState());
print(favourites[productId]);
    DioHelper.postData(
      lang: 'en',
      url: GET_FAVOURITE,
      data: {
        'product_id' : productId
      },
      token: token,
    ).then((value)
    {
      favouriteModel = FavouriteModel.fromJson(value!.data);

      if(favouriteModel!.status == false )
      {
        if(favourites[productId] == true) {
          favourites[productId] = false ;
        }else{
          favourites[productId] = true ;
        }
      }else{
        getFavouriteData();
      }
      emit(ShopSuccessFavouriteDataState(favouriteModel!));
    }).catchError((error) {
      if(favourites[productId] == true) {
        favourites[productId] = false ;
      }else{
        favourites[productId] = true ;
      }
      print(error.toString());
      emit(ShopErrorFavouriteDataState());
    });
  }

  FavouritesAddModel? favouritesAddModel;

  void getFavouriteData()
  {
    emit(ShopLoadingAddFavouriteDataState());

    DioHelper.getData(
      lang: 'en',
      url: GET_FAVOURITE,
      token: token,
    ).then((value)
    {
      favouritesAddModel = FavouritesAddModel.fromJson(value!.data);
      emit(ShopSuccessAddFavouriteDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorAddFavouriteDataState());
    });


  }


  ProfileModel? profileModel;

  void getProfileData()
  {
    emit(ShopLoadingAddProfileDataState());

    DioHelper.getData(
      lang: 'en',
      url: GET_PROFILE,
      token: token,
    ).then((value)
    {
      profileModel = ProfileModel.fromJson(value!.data);
      print(profileModel!.data!.name);
      emit(ShopSuccessAddProfileDataState(profileModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorAddProfileDataState());
    });


  }


  void updateProfileData({
    @required String? name,
    @required String? email,
    @required String? phone,
})
  {
    emit(ShopLoadingUpdateProfileDataState());

    DioHelper.putData(
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      },
      lang: 'en',
      url: UPDATE_PROFILE,
      token: token,
    ).then((value)
    {
      profileModel = ProfileModel.fromJson(value!.data);
      emit(ShopSuccessUpdateProfileDataState(profileModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateProfileDataState());
    });


  }
}
