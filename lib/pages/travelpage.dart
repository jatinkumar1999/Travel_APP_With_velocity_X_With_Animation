import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class TravelPage extends StatefulWidget {
  TravelPage({Key? key}) : super(key: key);

  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin {
  final url =
      "https://images.unsplash.com/photo-1625252568254-256958377c1d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80";

  final pic1 =
      "https://media.istockphoto.com/photos/big-ben-and-westminster-bridge-at-sunset-picture-id547499548?s=612x612";
  final pic2 =
      "https://media.istockphoto.com/photos/london-tower-bridge-illuminated-at-sunset-over-river-thames-panorama-picture-id628916454?s=612x612";

  TabController? tabcontroller;

  AnimationController? controller;
  Animation? anin;
  Animation? imageanimation;

  double anin2 = 3.0;
  double anin1 = 1.0;
  // final index = tabcontroller.index;

  @override
  void initState() {
    super.initState();

    tabcontroller = TabController(length: 4, vsync: this);
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    anin = Tween<double>(begin: -1.0, end: 0.0)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.linear));
  

    controller!.addListener(() {
      print(anin!.value.toString());
      setState(() {});
    });

    controller!.forward();
    withAnimation(
      vsync: this,
      initialValue: 1.0,
      curve: Curves.bounceIn,
      duration: Duration(seconds: 10),
      tween: Tween(begin: -1.0, end: 0.0),
      callBack: (animationVal, controllerVal) {
        anin1 = controllerVal;
        print(controllerVal);
        setState(() {});
      },
    );
    withRepeatAnimation(
      vsync: this,
      isRepeatReversed: true,
      tween: Tween(begin: 2.0, end: 4.0),
      callBack: (animationVal, controllerVal) {
        anin2 = controllerVal;
        print(controllerVal);
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabindex = tabcontroller?.index;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Vx.indigo400,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: VStack([
          VxBox().size(20, 2).coolGray800.make(),
          5.heightBox,
          VxBox().size(28, 2).coolGray800.make(),
          5.heightBox,
          VxBox().size(15, 2).coolGray800.make(),
        ]).pOnly(top: 15, left: 15),
      ),
      body: VStack(
        [
          VxBox(
            child: VStack(
              [
                VxBox()
                    .square(100)
                    .roundedFull
                    .neumorphic(
                      color: Vx.indigo400,
                      elevation: 40,
                    )
                    .bgImage(DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          url,
                        )))
                    .make(),
                15.heightBox,
                Transform(
                  transform:
                      Matrix4.translationValues(anin!.value * width, 0.0, 0.0),
                  child: "Hi, "
                      .richText
                      .withTextSpanChildren([
                        "Jatin Kumar".textSpan.bold.make(),
                      ])
                      .white
                      .xl2
                      .make(),
                ),
                15.heightBox,
                "Solo traveller".text.white.xl2.headline6(context).make(),
                15.heightBox,
              ],
            ),
          ).makeCentered(),
          VxTextField(
            borderType: VxTextFieldBorderType.none,
            borderRadius: 16,
            hint: "Search",
            fillColor: Vx.gray200.withOpacity(0.30),
            autofocus: false,
            prefixIcon: Icon(
              Icons.search_rounded,
              color: Colors.white,
            ),
          )
              .customTheme(themeData: ThemeData(brightness: Brightness.dark))
              .cornerRadius(15)
              .p16(),
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
            child: VxBox(
              child: VStack([
                TabBar(
                    controller: tabcontroller,
                    labelColor: Vx.indigo400,
                    unselectedLabelColor: Vx.warmGray300,
                    labelPadding: Vx.m12,
                    tabs: [
                      Icon(
                        Icons.map,
                        size: 30,
                      ).scale(scaleValue: tabindex == 0 ? anin2 : 1.0),
                      Icon(Icons.location_city, size: 30)
                          .scale(scaleValue: tabindex == 1 ? anin2 : 1.0),
                      Icon(Icons.restaurant, size: 30)
                          .scale(scaleValue: tabindex == 2 ? anin2 : 1.0),
                      Icon(Icons.person, size: 30)
                          .scale(scaleValue: tabindex == 3 ? anin2 : 1.0),
                    ]),
                TabBarView(
                  controller: tabcontroller,
                  children: [
                    "1",
                    "2",
                    "3",
                    "4",
                  ]
                      .map((e) => VStack([
                            "Discover to London".text.coolGray400.xl2.make(),
                            TabTile(
                              pic: pic1,
                              data: "Tower Bridge",
                              text1: "South Bridge",
                            ),
                            // TabTile(
                            //   pic: pic2,
                            //   data: "London Pye",
                            //   text1: "North Side",
                            // ),
                          ]))
                      .toList(),
                ).expand(),
              ]).p16(),
            ).white.make(),
          ).expand(),
        ],
      ),
    );
  }
}

class TabTile extends StatelessWidget {
  final String? pic, data, text1;
  final double? anin2;
  const TabTile({Key? key, this.pic, this.data, this.text1, this.anin2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HStack([
      Image.network(
        pic!,
        fit: BoxFit.cover,
      ).wh(context.percentWidth * 35, 100).cornerRadius(25),
      20.widthBox,
      VStack([
        data!.text.bold.make(),
        text1!.text.gray400.make().shimmer(),
        [
          VxRating(
            size: 15.0,
            onRatingUpdate: (value) {},
          ),
          5.widthBox,
          "(100)".text.gray400.make(),
        ].row()
      ]).expand(),
    ]).cornerRadius(25).backgroundColor(Vx.gray200).py8();
  }
}
