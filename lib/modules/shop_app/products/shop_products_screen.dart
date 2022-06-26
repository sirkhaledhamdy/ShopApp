import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/constants/components/components.dart';
import 'package:news_flutter/cubit/cubit.dart';
import 'package:news_flutter/cubit/states.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:news_flutter/models/categories_model.dart';
import 'package:news_flutter/models/home_model.dart';
import 'package:news_flutter/styles/colors.dart';

class ShopProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessFavouriteDataState) {
          if (state.model.status == false) {
            showToast(text: state.model.message!, state: ToastStates.error);
          } else {
            showToast(text: state.model.message!, state: ToastStates.success);
          }
        }
      },
      builder: (context, state) {
        return Center(
          child: (ShopCubit.get(context).homeData != null &&
                  ShopCubit.get(context).categoriesModel != null)
              ? productsBuilder(ShopCubit.get(context).homeData,
                  ShopCubit.get(context).categoriesModel, context)
              : CircularProgressIndicator(),
        );
      },
    );
  }

  Widget productsBuilder(
          HomeModel? model, CategoriesModel? categoriesModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model?.data?.banners
                  .map<Widget>(
                    (e) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 250.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 2),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1.0,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => buildCategoryItem(
                            categoriesModel!.data!.data[index]),
                        separatorBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: Container(
                                width: 1,
                                color: Colors.grey.shade300,
                              ),
                            ),
                        itemCount: categoriesModel!.data!.data.length),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'New Products',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              color: Colors.grey.shade200,
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.54,
                children: List.generate(
                  model!.data!.products.length,
                  (index) =>
                      buildGridProduct(model.data!.products[index], context),
                ),
              ),
            ),
          ],
        ),
      );






  Widget buildCategoryItem(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          CachedNetworkImage(
            imageUrl: model.image,
            placeholder: (context, url) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Container(
            width: 100.0,
            color: Colors.black.withOpacity(.8),
            child: Text(
              model.name,
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );

  Widget buildGridProduct(ProductsModel model, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                    model.image,
                  ),
                  width: double.infinity,
                  height: 180,
                ),
                if (model.discount != 0)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        backgroundColor: Colors.green,
                      ),
                    ),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      '${model.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        height: 1.3,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice.round()} EGP',
                          style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey.shade500,
                              decoration: TextDecoration.lineThrough),
                        ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${model.price.round()} EGP',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: defaultColor,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              ShopCubit.get(context)
                                  .postFavouriteData(model.id);
                            },
                            icon: CircleAvatar(
                              radius: 15,
                              backgroundColor:
                                  ShopCubit.get(context).favourites[model.id] ==
                                          true
                                      ? defaultColor
                                      : Colors.grey,
                              child: Icon(
                                Icons.favorite_outline,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );


}
