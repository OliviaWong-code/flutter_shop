import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../config/httpHeaders.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //用来显示请求回来的数据
  String showText = '还没有请求数据';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('请求远程数据'),),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: _jike,
                child:Text('请求数据'),
              ),
              Text(showText)
            ],
          ),
        ),
      ),
    );
  }

  void _jike(){
    print('开始向极客时间请求数据');
    getHttp().then((val){
      setState(() {
        showText = val['data'].toString();
      });
    });

  }


  Future getHttp() async{
    try{
      Response response = new Response();
      Dio dio = new Dio();
      dio.options.headers= httpHeaders;
      response = await dio.get('https://time.geekbang.org/serv/v1/column/newAll');
      print(response);
      return response.data;
    }catch(e){
      print(e);
    }
  }
}

