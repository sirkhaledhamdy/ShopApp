import 'package:news_flutter/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/network/local/cache_helper.dart';

import 'appstates.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIniState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  void changeAppMode({bool? fromShared})
  {
    if(fromShared != null){
      isDark = fromShared;

      emit(AppChangeModeState());
    }
     else{
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value)
      {
        emit(AppChangeModeState());
      });
    }

  }
}
