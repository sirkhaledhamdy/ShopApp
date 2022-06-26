import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/cubit/states.dart';
import '../../../constants/components/components.dart';
import '../../../cubit/cubit.dart';

class ShopFavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Center(
          child: (state is! ShopLoadingAddFavouriteDataState)
              ? ListView.separated(
              itemBuilder: (context, index) => buildFavouriteItem(
                  ShopCubit.get(context)
                      .favouritesAddModel!
                      .data!
                      .data![index].product,
                  context),
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 20,
                  end: 20,
                ),
                child: Container(
                  height: 1,
                  color: Colors.grey.shade300,
                ),
              ),
              itemCount: ShopCubit.get(context)
                  .favouritesAddModel!
                  .data!
                  .data!
                  .length)
              : CircularProgressIndicator(),
        );
      },
    );
  }

}
