import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/API/getFunctions.dart';
import 'package:treva_shop_flutter/API/provider_model.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'package:treva_shop_flutter/database/cart_model.dart';
import 'package:treva_shop_flutter/sharedPref/savedinfo.dart';
import 'dart:math';
import 'package:hive/hive.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

bool aaV(String a) {
  bool z = a.toLowerCase() == "true";
  return z;
}

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

class PoinBizProvider with ChangeNotifier {
  List allcategories;
  List allbanners = [];
  List myproducts =[];
  List allProducts = [];
  bool loading;

  ///Cart

  ///End of


  deletefromDisk(table)async{
    final box = await Hive.openBox<Address>(table);
    // final box1 = await Hive.openBox<CartModel>('cart');
    // final box2 = await Hive.openBox<SearchedWord>('searched');
    box.deleteFromDisk();
    // box1.deleteFromDisk();
    // box2.deleteFromDisk();

  }



  ///End Shipping

  ///WISHLIST


  ///end WISHLIST

  ///API Calls
  void getBanners() async {
    allbanners = await GetFunc.getBanners();

    notifyListeners();
  }

  void getProducts() async {
    allProducts = await GetFunc.getProducts();

    notifyListeners();
  }

  void getallCategories() async {
    allcategories = await GetFunc.getCategories();

    notifyListeners();
  }

  void getmyproducts() async {
    myproducts = await GetFunc.getMyProducts();

    notifyListeners();
  }

}
