import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/modules/shop/login/login-page.dart';
import 'package:flutter_app1/shared/component/component.dart';
import 'package:flutter_app1/shared/network/cacheHelper.dart';
import 'package:flutter_app1/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel(
      {@required this.image, @required this.title, @required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/logo.jpg',
      title: 'OnBoard 1 Title',
      body: 'OnBoard 1 Body',
    ),
    BoardingModel(
      image: 'assets/images/logo.jpg',
      title: 'OnBoard 2 Title',
      body: 'OnBoard 2 Body',
    ),
    BoardingModel(
      image: 'assets/images/logo.jpg',
      title: 'OnBoard 3 Title',
      body: 'OnBoard 3 Body',
    ),
  ];
  bool isLast = false;

  void getHttp() async {
    try {
      var response = await Dio().post(
        'https://student.valuxapps.com/api/login',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'lang': 'ar',
          },
        ),
        data: {'email': 'omar1@gmail.com', 'password': '1234567'},
      );
      print(response);
    } catch (e) {
      print(e);
    }
  }

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(
          context,
          ShopLoginScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [defaultTextButton(function: submit, text: 'skip')],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: boardController,
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  itemBuilder: (context, index) =>
                      buildBoardingScreen(boarding[index]),
                  itemCount: boarding.length,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        dotHeight: 10,
                        dotWidth: 10,
                        spacing: 5,
                        expansionFactor: 4,
                        activeDotColor: defaultColor),
                    count: boarding.length,
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardController.nextPage(
                            duration: Duration(
                              seconds: 1,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Widget buildBoardingScreen(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          SizedBox(height: 30),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(height: 15),
          Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      );
}
