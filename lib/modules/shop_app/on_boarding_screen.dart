import 'package:flutter/material.dart';
import 'package:news_flutter/constants/components/components.dart';
import 'package:news_flutter/modules/shop_app/login/shop_login_screen.dart';
import 'package:news_flutter/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../styles/colors.dart';

class BoardingModel {
  final String image;
  final String body;
  final String title;

  BoardingModel({required this.image, required this.body, required this.title});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  bool isLast = false;

  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value)
    {
      if(value == true )
      {
        navigateAndFinish(context, ShopLoginScreen(),);

      }
    }

    );
  }

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/1.png',
      body: 'Online Order',
      title: 'Explore many products',
    ),
    BoardingModel(
      image: 'assets/images/2.png',
      body: 'Easy  Payment',
      title: 'Choose and checkout',
    ),
    BoardingModel(
      image: 'assets/images/3.png',
      body: 'Fast Order',
      title: 'Get it home',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: submit,
            child: Text('SKIP'),),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index){
                  if(index == boarding.length - 1){
                    setState((){
                      isLast = true;
                    });
                  }else{
                    setState((){
                      isLast = false;
                    });
                  }
                },
                controller: boardController,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey.shade400,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                      if(isLast == true){
                        submit();

                      }else{
                        boardController.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget buildBoardingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(
              '${model.image}',
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          '${model.title}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          '${model.body}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ),
      ],
    );
