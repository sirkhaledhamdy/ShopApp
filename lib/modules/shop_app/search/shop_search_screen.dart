import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/constants/components/components.dart';
import 'package:news_flutter/modules/shop_app/search/cubit/search_cubit.dart';
import 'package:news_flutter/modules/shop_app/search/cubit/search_states.dart';

class ShopSearchScreen extends StatelessWidget {
  var formKey = GlobalKey();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit , SearchStates>(
        listener: (context , state){},
        builder: (context , state){
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (String value){
                          if(value.isEmpty){
                            return 'User Must Input Data';
                          }
                          return null;
                        },
                        label: 'Search Products',
                        prefix: Icons.search,
                      onSubmit: (String text)
                      {
                          SearchCubit.get(context).search(text);
                      },
                    ),
                    SizedBox(height: 10,),
                    if(state is SearchLoadingState)
                    LinearProgressIndicator(),
                    SizedBox(height: 20,),
                    if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) => buildFavouriteItem(SearchCubit.get(context).model!.data!.data![index], context , isOldPrice: false,),
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
                          itemCount: SearchCubit.get(context).model!.data!.data!.length),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}
