import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';

import 'package:flutter_medical_ui/util/DataFile.dart';
import 'package:flutter_medical_ui/util/PrefData.dart';
import 'package:flutter_medical_ui/util/SizeConfig.dart';

import 'generated/l10n.dart';
import 'main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'model/IntroModel.dart';

class IntroPage extends StatefulWidget {
  // final ValueChanged<bool> onChanged;

  // IntroPage(this.onChanged);

  @override
  _IntroPage createState() {
    return _IntroPage();
    // return _IntroPage(this.onChanged);
  }
}

class _IntroPage extends State<IntroPage> {
  int _position = 0;

  // final ValueChanged<bool> onChanged;

  // _IntroPage(this.onChanged);

  Future<bool> _requestPop() {
    Future.delayed(const Duration(milliseconds: 200), () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });

    return new Future.value(false);
  }

  final controller = PageController();

  List<IntroModel> introModelList;

  String s;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    introModelList = DataFile.getIntroModel(context);


    double defMargin = ConstantWidget.getScreenPercentSize(context, 2);
    double mainHeight = ConstantWidget.getScreenPercentSize(context, 42);

    setState(() {});

    if(
    s==null
    ){
      s = S.of(context).continueText;
    }

    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        height:double.infinity,
                        child: PageView.builder(
                          controller: controller,
                          itemBuilder: (context, position) {
                            return Container(

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                            //       Container(
                            //         height: mainHeight,
                            //
                            //   child:  CustomPaint(
                            //       painter: CurvePainter(),
                            // ),
                            //
                            //
                            //       )
                                  Container(


                                    height: mainHeight,


                                    padding: EdgeInsets.all((defMargin*5)),

                                    // child: ShapeOfView(
                                    //   shape: ArcShape(
                                    //       direction: ArcDirection.Outside,
                                    //       height: 20,
                                    //       // height: ConstantWidget.getScreenPercentSize(context,12),
                                    //       position: ArcPosition.Bottom
                                    //
                                    //   ),
                                    //
                                    //   elevation: 4,
                                    //   height: mainHeight, //height & width are optional
                                      child: Container(

                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(ConstantData.assetsPath + introModelList[position].image),
                                                fit: BoxFit.cover)
                                        ),
                                      // )
                                  ),),
                                  Expanded(child: Column(
                                    children: [


                                      SizedBox(height: defMargin*2,),

                                      // Container(
                                      //   margin: EdgeInsets.all(defMargin),
                                      //   child: SmoothPageIndicator(
                                      //     controller: controller,  // PageController
                                      //     count:  introModelList.length,
                                      //
                                      //     effect:  WormEffect(activeDotColor: ConstantData.primaryColor),  // your preferred effect
                                      //
                                      //   )
                                      //   ,
                                      //
                                      // ),

                                      SizedBox(height: defMargin*2,),
                                      Padding(
                                        padding: EdgeInsets.all(defMargin),

                                        child: ConstantWidget.getCustomText(
                                            introModelList[position].name,
                                            ConstantData.mainTextColor, 2,
                                            TextAlign.start,
                                            FontWeight.bold, 25),

                                      ),

                                      ConstantWidget.getCustomText(
                                          introModelList[position].desc,
                                          ConstantData.textColor, 4, TextAlign.center,
                                          FontWeight.w500, ConstantData.font18Px),
                                    ],
                                  ))





                                ],
                              ),
                            );
                          },
                          itemCount: introModelList.length,
                          onPageChanged: _onPageViewChange,
                        ),
                      ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   mainAxisSize: MainAxisSize.max,
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     Container(
                      //       child: SmoothPageIndicator(
                      //         controller: controller, // PageController
                      //         count: introModelList.length,
                      //         effect: WormEffect(
                      //             activeDotColor: ConstantData
                      //                 .primaryColor), // your preferred effect
                      //       ),
                      //       // child: SmoothPageIndicator(
                      //       //   controller: controller,
                      //       //   count: introModelList.length,
                      //       //   effect: ScaleEffect(
                      //       //       spacing: (defMargin/2),
                      //       //       radius: 10.0,
                      //       //       dotWidth: defMargin,
                      //       //       dotHeight: defMargin,
                      //       //       dotColor: ConstantData.disableIconColor,
                      //       //       paintStyle: PaintingStyle.stroke,
                      //       //       strokeWidth: 1,
                      //       //       activeDotColor: ConstantData.primaryColor),
                      //       // ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),



                Container(
                  margin: EdgeInsets.all(defMargin),
                  child: SmoothPageIndicator(
                    controller: controller,  // PageController
                    count:  introModelList.length,

                    effect:  WormEffect(activeDotColor: ConstantData.primaryColor),  // your preferred effect

                  )
                  ,

                ),



                Container(
                  margin: EdgeInsets.symmetric(horizontal: defMargin * 2),
                  height: ConstantWidget.getScreenPercentSize(context, 15),
                  child: Center(
                    child: getButtonWidget(
                        context, s, ConstantData.primaryColor, () {

                     if (_position == 2){
                       PrefData.setIsIntro(false);
                       Navigator.of(context).pop(true);
                       Navigator.push(
                           context,
                           MaterialPageRoute(
                               builder: (context) => MyHomePage()));
                      }else{
                       _position++;
                       controller.jumpToPage(_position);
                       setState(() {

                       });
                     }
                    }),
                  ),
                )
              ],
            ),
          ),




        ),
        onWillPop: _requestPop);
  }

  Widget getButtonWidget(
      BuildContext context, String s, var color, Function function) {
    ConstantData.setThemePosition();
    double height = ConstantWidget.getScreenPercentSize(context, 8.5);
    double radius = ConstantWidget.getPercentSize(height, 50);
    double fontSize = ConstantWidget.getPercentSize(height, 30);

    return InkWell(
      child: Container(
        height: height,
        margin: EdgeInsets.symmetric(
            vertical: ConstantWidget.getScreenPercentSize(context, 1.2)),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
        ),
        child: Center(
            child: ConstantWidget.getDefaultTextWidget(
                s,
                TextAlign.center,
                FontWeight.w500,
                fontSize,
                (color == ConstantData.primaryColor)
                    ? Colors.white
                    : ConstantData.mainTextColor)),
      ),
      onTap: function,
    );
  }

  _onPageViewChange(int page) {
    _position = page;

    // controller.jumpToPage(_position);

    if(_position==2){
      s = "Get Started";

    }else{
      s = S.of(context).continueText;
    }
    setState(() {});
  }
}

// class LinePathClass extends CustomClipper {
//   @override
//   Path getClip(Size size) {
//     // TODO: implement getClip
//     var path = new Path();
//     path.lineTo(0, 300);
//     path.lineTo(325, 0);
//     path.lineTo(size.width - 300, size.height - 500);
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper oldClipper) {
//     // TODO: implement shouldReclip
//     return false;
//   }
//
// }
