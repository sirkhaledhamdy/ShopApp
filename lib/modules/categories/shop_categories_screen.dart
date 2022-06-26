import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/cubit/cubit.dart';
import 'package:news_flutter/cubit/states.dart';

import '../../models/categories_model.dart';

class ShopCategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context , state){},
      builder: (context, state){
        return ListView.separated(
          itemBuilder: (context , index) => buildCategoryItem(ShopCubit.get(context).categoriesModel!.data!.data[index]),
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsetsDirectional.only(start: 20, end: 20,),
            child: Container(
              height: 1,
              color: Colors.grey.shade300,
            ),
          ),
          itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length,);
      },
    );
  }
  Widget buildCategoryItem(DataModel? model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(
            model!.image,
          ),
          width: 120,
          height: 120,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 10,),
        Text(model.name,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Icon(Icons.arrow_forward_ios)
      ],
    ),
  );
}
