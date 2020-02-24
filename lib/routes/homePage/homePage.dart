import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/service/homeServices.dart';
import 'package:flutter_app/viewModel/itemVM.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> imageList = List();

  @override
  void initState() {
    imageList
      ..add(Image.network(
        'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2726034926,4129010873&fm=26&gp=0.jpg',
        fit: BoxFit.fill,
      ))
      ..add(Image.asset('assets/imgs/hw.jpg'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("果核"),
        ),
        body: new SingleChildScrollView(
          child: Column(
            children: <Widget>[
              swiper(),
              ListTile(
                title: Text("教务服务"),
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
                title: Text("校园系统"),
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
        ));
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
          print('点击了第$index');
        },
      ),
    );
  }

  Widget _swiperBuilder(BuildContext context, int index) {
    return (imageList[index]);
  }
}
