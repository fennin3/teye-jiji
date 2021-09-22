import 'package:flutter/cupertino.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
import 'package:treva_shop_flutter/Library/carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class detailProduk extends StatefulWidget {
  Map gridItem;

  detailProduk(this.gridItem);

  @override
  _detailProdukState createState() => _detailProdukState(gridItem);
}

/// Detail Product for Recomended Grid in home screen
class _detailProdukState extends State<detailProduk> {
  double rating = 3.5;
  int starCount = 5;

  /// Declaration List item HomeGridItemRe....dart Class
  final Map gridItem;

  _detailProdukState(this.gridItem);

  double rate = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  static BuildContext ctx;
  int valueItemChart = 0;
  int _nu = 0;
  int _num = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  /// BottomSheet for view more in specification
  void _bottomSheet(String text) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return SingleChildScrollView(
            child: Container(
              color: Colors.black26,
              child: Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 20.0)),
                      Center(
                          child: Text(
                        "Description",
                        style: _subHeaderCustomStyle,
                      )),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
                        child: Text("$text", style: _detailText),
                      ),

                      // Padding(
                      //   padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                      //   child: Text(
                      //     " - Lorem ipsum is simply dummy  ",
                      //     style: _detailText,
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  /// Custom Text black
  static var _customTextStyle = TextStyle(
    color: Colors.black,
    fontFamily: "Gotik",
    fontSize: 17.0,
    fontWeight: FontWeight.w800,
  );

  /// Custom Text for Header title
  static var _subHeaderCustomStyle = TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.w700,
      fontFamily: "Gotik",
      fontSize: 16.0);

  /// Custom Text for Detail title
  static var _detailText = TextStyle(
      fontFamily: "Gotik",
      color: Colors.black54,
      letterSpacing: 0.3,
      wordSpacing: 0.5);

  /// Variable Component UI use in bottom layout "Top Rated Products"
  var _suggestedItem = Padding(
    padding:
        const EdgeInsets.only(left: 15.0, right: 20.0, top: 30.0, bottom: 20.0),
    child: Container(
      height: 280.0,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Top Rated Products",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: "Gotik",
                    fontSize: 15.0),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  "See All",
                  style: TextStyle(
                      color: appColor.withOpacity(0.8),
                      fontFamily: "Gotik",
                      fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(top: 20.0, bottom: 2.0),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                FavoriteItem(
                  image: "assets/imgItem/shoes1.jpg",
                  title: "Firrona Skirt!",
                  Salary: "\$ 10",
                  Rating: "4.8",
                  sale: "923 Sale",
                ),
                Padding(padding: EdgeInsets.only(left: 10.0)),
                FavoriteItem(
                  image: "assets/imgItem/acesoris1.jpg",
                  title: "Arpenaz 4",
                  Salary: "\$ 200",
                  Rating: "4.2",
                  sale: "892 Sale",
                ),
                Padding(padding: EdgeInsets.only(left: 10.0)),
                FavoriteItem(
                  image: "assets/imgItem/kids1.jpg",
                  title: "Mon Cheri Pingun",
                  Salary: "\$ 3",
                  Rating: "4.8",
                  sale: "110 Sale",
                ),
                Padding(padding: EdgeInsets.only(left: 10.0)),
                FavoriteItem(
                  image: "assets/imgItem/man1.jpg",
                  title: "Polo T Shirt",
                  Salary: "\$ 8",
                  Rating: "4.4",
                  sale: "210 Sale",
                ),
                Padding(padding: EdgeInsets.only(right: 10.0)),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Future<void> _makePhoneCall(String url) async {
    print(url);
    if (await canLaunch("tel:" + url)) {
      await launch("tel:" + url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget build(BuildContext context) {
    final _pro = Provider.of<PoinBizProvider>(context, listen: true);
    return Scaffold(
      key: _key,
      appBar: AppBar(
        actions: <Widget>[],
        elevation: 0.5,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Product Detail",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black54,
            fontSize: 17.0,
            fontFamily: "Gotik",
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /// Header image slider
                  Stack(
                    children: [
                      Container(
                        height: 300.0,
                        child: Hero(
                          tag: "hero-grid-${gridItem['id']}",
                          child: Material(
                            child: new Carousel(
                              dotColor: Colors.black26,
                              dotIncreaseSize: 1.7,
                              dotBgColor: Colors.transparent,
                              autoplay: false,
                              boxFit: BoxFit.cover,
                              images: [
                                NetworkImage(base_url2 + gridItem['image']),
                                // for (var img in gridItem['gallery'])
                                //   NetworkImage(img['path']),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //
                    ],
                  ),

                  /// Background white title,price and ratting
                  Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Color(0xFF656565).withOpacity(0.15),
                        blurRadius: 1.0,
                        spreadRadius: 0.2,
                      )
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            gridItem['name'],
                            style: _customTextStyle,
                          ),
                          Padding(padding: EdgeInsets.only(top: 5.0)),
                          Text(
                            "GHc " + gridItem['price'].toString(),
                            style: _customTextStyle,
                          ),
                          Padding(padding: EdgeInsets.only(top: 10.0)),
                          Divider(
                            color: Colors.black12,
                            height: 1.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: Text(
                                    "${widget.gridItem['stock']} Available",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  /// Background white for chose Size and Color

                  /// Background white for description
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10),
                      width: 600.0,
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Color(0xFF656565).withOpacity(0.15),
                          blurRadius: 1.0,
                          spreadRadius: 0.2,
                        )
                      ]),
                      child: Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                "Description",
                                style: _subHeaderCustomStyle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0,
                                  right: 20.0,
                                  bottom: 10.0,
                                  left: 20.0),
                              child: Text(gridItem['description'],
                                  style: _detailText),
                            ),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  _bottomSheet(gridItem['description']);
                                },
                                child: Text(
                                  "View More",
                                  style: TextStyle(
                                    color: appColor,
                                    fontSize: 15.0,
                                    fontFamily: "Gotik",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10),
                      width: 600.0,
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Color(0xFF656565).withOpacity(0.15),
                          blurRadius: 1.0,
                          spreadRadius: 0.2,
                        )
                      ]),
                      child: Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                "Seller Details",
                                style: _subHeaderCustomStyle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0,
                                  right: 20.0,
                                  bottom: 10.0,
                                  left: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${widget.gridItem['user']['first_name']} ${widget.gridItem['user']['last_name']}", style: _detailText,),
                                  Text("${widget.gridItem['user']['email']}", style: _detailText,),


                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// Background white for Ratting

                  // _suggestedItem
                ],
              ),
            ),
          ),

          /// If user click icon chart SnackBar show
          /// this code to show a SnackBar
          /// and Increase a valueItemChart + 1
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            _makePhoneCall(widget.gridItem['user']['profile']['contact']),
        backgroundColor: appColor,
        child: Icon(Icons.phone),
      ),
    );
  }

  Widget _buildRating(String date, String details, double rate, String image) {
    return ListTile(
      leading: Container(
        height: 45.0,
        width: 45.0,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(50.0))),
      ),
      title: Row(
        children: <Widget>[

          SizedBox(width: 8.0),
          Text(
            date,
            style: TextStyle(fontSize: 12.0),
          )
        ],
      ),
      subtitle: Text(
        details,
        style: _detailText,
      ),
    );
  }
}

class SizeWidget extends StatelessWidget {
  final String text;
  final index;
  final nu;

  SizeWidget({this.text, this.index, this.nu});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: index != nu ? 37.0 : 50,
      width: index != nu ? 37.0 : 50,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: index != nu ? Colors.black54 : appColor),
          shape: BoxShape.circle),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: index != nu ? Colors.black54 : appColor),
        ),
      ),
    );
  }
}

class ColorWidget extends StatelessWidget {
  final color;
  final index;
  final nu;

  ColorWidget({this.color, this.index, this.nu});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: index != nu ? 37.0 : 50,
      width: index != nu ? 37.0 : 50,
      decoration: BoxDecoration(
          color: color,
          border: Border.all(color: index != nu ? Colors.black54 : appColor),
          shape: BoxShape.circle),
    );
  }
}

/// Class for card product in "Top Rated Products"
class FavoriteItem extends StatelessWidget {
  String image, Rating, Salary, title, sale;

  FavoriteItem({this.image, this.Rating, this.Salary, this.title, this.sale});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF656565).withOpacity(0.15),
                blurRadius: 4.0,
                spreadRadius: 1.0,
//           offset: Offset(4.0, 10.0)
              )
            ]),
        child: Wrap(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 150.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7.0),
                          topRight: Radius.circular(7.0)),
                      image: DecorationImage(
                          image: AssetImage(image), fit: BoxFit.cover)),
                ),
                Padding(padding: EdgeInsets.only(top: 15.0)),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    title,
                    style: TextStyle(
                        letterSpacing: 0.5,
                        color: Colors.black54,
                        fontFamily: "Sans",
                        fontWeight: FontWeight.w500,
                        fontSize: 13.0),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 1.0)),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    Salary,
                    style: TextStyle(
                        fontFamily: "Sans",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            Rating,
                            style: TextStyle(
                                fontFamily: "Sans",
                                color: Colors.black26,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 14.0,
                          )
                        ],
                      ),
                      Text(
                        sale,
                        style: TextStyle(
                            fontFamily: "Sans",
                            color: Colors.black26,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _line() {
  return Container(
    height: 0.9,
    width: double.infinity,
    color: Colors.black12,
  );
}
