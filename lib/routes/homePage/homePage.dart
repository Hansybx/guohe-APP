import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/service/homeServices.dart';
import 'package:flutter_app/viewModel/itemVM.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluwx/fluwx.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //todo 后期做平板适配（优先级低）
  // 判断是否是大屏幕
  bool isLargeScreen;

  List<Widget> imageList = List();

  Widget selectWidget = null;

  @override
  void initState() {
    imageList
      ..add(Image.network(
        'https://pic.downk.cc/item/5e849a81504f4bcb0437649f.jpg',
        fit: BoxFit.fill,
      ))
      ..add(Image.asset('assets/imgs/hw.jpg'));

    super.initState();

//    weChatResponseEventHandler.listen((res) {
//      if (res is WeChatLaunchMiniProgramResponse) {
//        if (mounted) {
//          setState(() {
//            _result = "isSuccessful:${res.isSuccessful}";
//          });
//        }
//      }
//    });
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            "发现",
            style: new TextStyle(color: Colors.black),
          ),
        ),
        body: new OrientationBuilder(builder: (context, ori) {
          //判断屏幕宽度
          if (MediaQuery.of(context).size.width > 600) {
            isLargeScreen = true;
          } else {
            isLargeScreen = false;
          }
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                swiper(),
                ListTile(
                  title: Text("校园"),
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: new NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  padding: EdgeInsets.symmetric(vertical: 0),
                  children: eduServiceList
                      .map((item) => ServiceItem(widget: item))
                      .toList(),
                ),
                new Divider(),
                ListTile(
                  title: Text("系统"),
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: new NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  padding: EdgeInsets.symmetric(vertical: 0),
                  children: eduSystemList
                      .map((item) => ServiceItem(widget: item))
                      .toList(),
                ),
                new Divider(),
              ],
            ),
          );
        }));
  }

  // 轮播图
  Widget swiper() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: Swiper(
        itemCount: imageList.length,
        itemBuilder: _swiperBuilder,
        pagination: SwiperPagination(
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),
            builder: DotSwiperPaginationBuilder(
                color: Colors.black54, activeColor: Colors.white)),
        controller: SwiperController(),
        scrollDirection: Axis.horizontal,
        autoplay: true,
        onTap: (index) {
          //todo 完善轮播图逻辑
          print('点击了第$index');
        },
      ),
    );
  }

  Widget _swiperBuilder(BuildContext context, int index) {
    return (imageList[index]);
  }
}
