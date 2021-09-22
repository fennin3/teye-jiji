import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:treva_shop_flutter/API/provider_model.dart';
import 'dart:convert';

import 'package:treva_shop_flutter/constant.dart';
import 'package:treva_shop_flutter/sharedPref/savedinfo.dart';


class GetFunc{
  static getCategories()async{
    List _data;
    try{
      http.Response response = await http.get(Uri.parse(base_url+"products/cat-retrieve/"));

      if(response.statusCode < 206){
        _data = json.decode(response.body)["data"];
      }
      else{
        _data = [];
      }
      return _data;
    }
    on SocketException{
      EasyLoading.showInfo("No Internet");
    }
  }
  static getBanners()async{
    List _data;
    http.Response response = await http.get(Uri.parse(base_url+"products/banner/"));
    print(response.statusCode);

    if(response.statusCode < 206){
      _data = json.decode(response.body)["data"];
    }
    else{
      _data = [];
    }

    return _data;
  }

  static getProducts()async{
    List _data;
    http.Response response = await http.get(Uri.parse(base_url+"products/retrieve/"));

    if(response.statusCode < 206){
      _data = json.decode(response.body)["data"];
    }
    else{
      _data = [];
    }

    return _data;
  }


  static getMyProducts()async{
    final userId = await UserData.getUserId();
    List _data;
    http.Response response = await http.get(Uri.parse(base_url+"products/retrieve/$userId/"));

    if(response.statusCode < 206){
      _data = json.decode(response.body)["data"];
    }
    else{
      _data = [];
    }

    return _data;
  }





}