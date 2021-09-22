import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
import 'package:treva_shop_flutter/UI/HomeUIComponent/Home.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'package:provider/provider.dart';



class MyProducts extends StatefulWidget {
  const MyProducts({Key key}) : super(key: key);

  @override
  _MyProductsState createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  @override
  Widget build(BuildContext context) {
    final _pro = Provider.of<PoinBizProvider>(context, listen: true);
    var Grid = _pro.myproducts.isNotEmpty ? Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Text(_pro.allProducts.length.toString())


          GridView.count(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              childAspectRatio: 0.7,
              // crossAxisCount: 2,
              primary: false,


              crossAxisCount: 2,
              children: List.generate(
                _pro.myproducts.length,
                    (index) => ItemGrid(_pro.myproducts[index]),
              ))
        ],
      ),
    ) : Center(
      child: Text("You have no products.", style: TextStyle(fontSize: 20),),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        centerTitle: true,
        leading:InkWell(
            onTap: ()=>Navigator.pop(context),
            child: Icon(Icons.arrow_back, color: Colors.white,)),
        title: Text("My Products", style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(child: Grid),
    );
  }
}
