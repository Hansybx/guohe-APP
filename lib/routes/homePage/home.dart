import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/apis.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:flutter_app/service/homeServices.dart';
import 'package:flutter_app/viewModel/itemVM.dart';
import 'package:flutter_app/widgets/browser.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //todo 后期做平板适配（优先级低）
  // 判断是否是大屏幕
  bool isLargeScreen;

  List<Widget> imageList = List();
  List refUrl = [];
  SwiperController _swiperController;

  Widget selectWidget = null;

  Future<dynamic> swiperImgs() async {
    Response res = await Dio().get(Constant.SWIPERIMGS);
    if (res.statusCode == 200) {
      if (res.data['code'] == 200) {
        return res.data['info'];
      }
    }
  }

  @override
  void initState() {
    swiperImgs().then((res) {
      if (mounted) {
        setState(() {
          for (var item in res) {
            imageList.add(CachedNetworkImage(
              placeholder: (context, url) => new Container(
                width: 80,
                height: 80,
                child: new Center(child: new CircularProgressIndicator()),
              ),
              imageUrl: item['img'],
              fit: BoxFit.fill,
            ));
            refUrl.add(item['url']);
          }
        });
      }
    });

    _swiperController = new SwiperController();
    _swiperController.startAutoplay();

//    imageList
//      ..add(CachedNetworkImage(
//        placeholder: (context, url) => new Container(
//          width: 80,
//          height: 80,
//          child: new Center(child: new CircularProgressIndicator()),
//        ),
//        imageUrl: 'https://stu.guohe3.cn/cp1.png',
//        fit: BoxFit.fill,
//      ))
//      ..add(Image.asset('assets/imgs/cp2.png'));

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
    _swiperController.stopAutoplay();
    _swiperController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: new OrientationBuilder(builder: (context, ori) {
          //判断屏幕宽度
          if (MediaQuery.of(context).size.width > 600) {
            isLargeScreen = true;
          } else {
            isLargeScreen = false;
          }
          return SingleChildScrollView(
              child: isLargeScreen
                  ? Center(child: Container(width: 600, child: homePage()))
                  : homePage());
        }));
  }

  Widget homePage() {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        swiper(),
        ListTile(
          title: Text(S.of(context).campus),
        ),
        GridView.count(
          shrinkWrap: true,
          physics: new NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          padding: EdgeInsets.symmetric(vertical: 0),
          children: getEduServiceList(context)
              .map((item) => ServiceItem(widget: item))
              .toList(),
        ),
        new Divider(),
//        ListTile(
//          title: Text(S.of(context).schoolService),
//        ),
//        GridView.count(
//          shrinkWrap: true,
//          physics: new NeverScrollableScrollPhysics(),
//          crossAxisCount: 4,
//          padding: EdgeInsets.symmetric(vertical: 0),
//          children: getSchoolServiceList(context)
//              .map((item) => ServiceItem(widget: item))
//              .toList(),
//        ),
//        new Divider(),
        ListTile(
          title: Text(S.of(context).system),
        ),
        GridView.count(
          shrinkWrap: true,
          physics: new NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          padding: EdgeInsets.symmetric(vertical: 0),
          children: getSystemList(context)
              .map((item) => ServiceItem(widget: item))
              .toList(),
        ),
        new Divider(),
      ],
    );
  }

  // 轮播图
  Widget swiper() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      width: MediaQuery.of(context).size.width,
      height: isLargeScreen ? 400 : 250,
      child: Swiper(
        itemCount: imageList.length,
        itemBuilder: _swiperBuilder,
        pagination: SwiperPagination(
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),
            builder: DotSwiperPaginationBuilder(
                color: Colors.black54, activeColor: Colors.white)),
        loop: false,
        controller: _swiperController,
        scrollDirection: Axis.horizontal,
        autoplay: true,
        onTap: (index) {
          //todo 完善轮播图逻辑
          if (refUrl[index].length != 0) {
            print(refUrl[index].length != 0);
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return Browser(url: refUrl[index], title: "");
            }));
          }
        },
      ),
    );
  }

  Widget _swiperBuilder(BuildContext context, int index) {
    return (imageList[index]);
  }
}
