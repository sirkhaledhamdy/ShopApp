import 'package:flutter/material.dart';
import 'package:news_flutter/modules/shop_app/login/shop_login_screen.dart';
import 'package:news_flutter/modules/shop_app/shop_layout.dart';
import 'package:news_flutter/styles/themes.dart';
import 'constants/constants.dart';
import 'cubit/appCubit.dart';
import 'cubit/appStates.dart';
import 'cubit/cubit.dart';
import 'modules/shop_app/on_boarding_screen.dart';
import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      DioHelper.init();
      await CacheHelper.init();
      bool? isDark = CacheHelper.getData(
        key: 'isDark',
      );
      Widget? widget;
      bool? onBoarding = CacheHelper.getData(
        key: 'onBoarding',
      );
       token = CacheHelper.getData(
        key: 'token',
      );

      if (onBoarding != null) {
        if (token != null) {
          widget = ShopLayOut();
        } else {
          widget = ShopLoginScreen();
        }
      } else {
        widget = OnBoardingScreen();
      }

      runApp(MyApp(
        isDark: isDark,
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;
  MyApp({this.isDark, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubit()..getHomeData()..getCategoryData()..getFavouriteData()..getProfileData(),
        ),
        BlocProvider(
          create: (context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                 ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
