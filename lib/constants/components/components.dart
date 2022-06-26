import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_flutter/models/add_favourite_model.dart';
import '../../cubit/cubit.dart';
import '../../styles/colors.dart';


Widget buildarticalItem(article, context) => InkWell(
  onTap: (){
  },
  child:   Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: [
        Container(
          width: 130.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage('${article['urlToImage']}',
              ),
  
  
              fit: BoxFit.cover,
            ),
          ),
  
        ),
        SizedBox(width: 20.0,),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text('${article['title']}',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Text('${article['publishedAt']}',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  ),
);


Widget builderNews(list) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) => buildarticalItem(list[index], context),
    separatorBuilder: (context, index) => Padding(
      padding: const EdgeInsetsDirectional.only(start: 16.0),
      child: Container(
        height: 1,
        color: Colors.grey.shade300,
      ),
    ),
    itemCount: list.length);

Widget defaultButton ({
  double width = double.infinity,
  Color color = Colors.red,
  required void Function()? onPressed,
  required String text,
}) => Container(
    width: width,
    color: color,
  child: MaterialButton(
    onPressed: onPressed,
    child: Text(
      text.toUpperCase(),
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
    );



Widget defaultFormField ({
  required TextEditingController controller,
  required TextInputType type,
  void Function(String)? onSubmit,
  void Function(String)? onChange,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool isPass = false,
  void Function()? suffixPressed,
  String? errorText,
}) => TextFormField(

  decoration: InputDecoration(
    errorText: errorText,
    labelText: label,
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: suffix != null ? IconButton(
      onPressed: suffixPressed,
      icon: Icon(
        suffix
      ),
    ) : null ,
    border: OutlineInputBorder(),
  ),

  controller: controller,
  keyboardType: type,
  obscureText: isPass,
  onFieldSubmitted: onSubmit,
  validator: (value){
    if(value!.isEmpty) {
      return 'User Must Input Data';
    }
    return null;
  },
);

void navigateTo(context, widget)
{
  Navigator.push(context, MaterialPageRoute(builder:
  (context) => widget,
  ),);
}

void navigateAndFinish(context, widget)
{
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
    builder: (context) => widget,
  ),
      (Route<dynamic> route) => false,
  );
}

void showToast({
  required String text,
  required ToastStates state,
}) => Fluttertoast.showToast(
  msg: text,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor: choseToastColor(state),
  textColor: Colors.white,
  fontSize: 16.0,
);

// enum
enum ToastStates {success , error, warning}

Color? choseToastColor(ToastStates state)
{
  Color color;
  switch(state)
  {
    case ToastStates.success:
      color = Colors.green.withOpacity(.8);
      break;
    case ToastStates.error:
      color =  Colors.red.withOpacity(.8);
      break;
    case ToastStates.warning:
      color =  Colors.orangeAccent.withOpacity(.8);
      break;
  }
  return color;
}


Widget buildFavouriteItem(model, context, {bool isOldPrice = true,}) => Padding(
  padding: const EdgeInsets.all(16.0),
  child: Container(
    height: 120,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(
                model.image,
              ),
              width: 120,
              height: 120,
            ),
            if (model.discount != 0 && isOldPrice == true)
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
        SizedBox(
          width: 20,
        ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    if (model.discount != 0 && isOldPrice == true)
                      Text(
                        model.oldPrice.toString(),
                        style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey.shade500,
                            decoration: TextDecoration.lineThrough),
                      ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      model.price.toString(),
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
                                .postFavouriteData(model!.id);
                          },
                          icon: CircleAvatar(
                            radius: 15,
                            backgroundColor: ShopCubit.get(context)
                                .favourites[model!.id] ==
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
  ),
);

