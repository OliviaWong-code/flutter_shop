import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_mothod.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('百姓生活+'),),
      body: FutureBuilder(//异步UI更新
        future: getHomePageContent(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var data = json.decode(snapshot.data.toString());
            //数据处理
            List<Map> swiper = (data['data']['slides'] as List).cast(); //顶部轮播组件
            List<Map> navigatorList = (data['data']['category'] as List).cast(); //顶部轮播组件
            String adPicture = data['data']['advertesPicture']['PICTURE_ADDRESS'];
            String leaderImage = data['data']['shopInfo']['leaderImage'];
            String leaderPhone = data['data']['shopInfo']['leaderPhone'];

            return Column(
              children: <Widget>[
                SwiperDiy(swiperDataList: swiper),
                TopNavigator(navigatorList: navigatorList),
                ADBanner(adPicture: adPicture),
                LeaderPhone(leaderImage: leaderImage,leaderPhone: leaderPhone,)
              ],
            );
          }else{
            return Center(
              child: Text('加载中'),
            );
          }
        },
      ),
    );
  }
}

/// *首页轮播组件
class SwiperDiy extends StatelessWidget {

  final List swiperDataList ;

  SwiperDiy({Key key , this.swiperDataList}):super(key : key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        //构造器 有初始化数据
        itemBuilder: (BuildContext context,int index){
          return Image.network('${swiperDataList[index]['image']}',fit: BoxFit.fill);
        },
        itemCount: swiperDataList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}



/// *首页导航组件
class TopNavigator extends StatelessWidget {
  //初始化list
  final List navigatorList ;

  TopNavigator({Key key , this.navigatorList}):super(key:key);

  Widget _gridViewItemUI(BuildContext context , item){
    return InkWell(
      onTap: (){print('点击了导航');},
      child: Column(
        children: <Widget>[
          Image.network(item['image'] ,width: ScreenUtil().setWidth(95),),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
          crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item){
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

///* 广告条
class ADBanner extends StatelessWidget {
  final String adPicture;
  ADBanner({Key key, this.adPicture}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }
}


///* 店长电话
class LeaderPhone extends StatelessWidget {
  final String leaderImage;//店长图片
  final String leaderPhone;//店长电话

  LeaderPhone({Key key,this.leaderImage,this.leaderPhone}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: (){},
        child: Image.network(leaderImage),
      ),
    );
  }
}


