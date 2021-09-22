import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
import 'package:treva_shop_flutter/UI/AcountUIComponent/addproduct.dart';
import 'package:treva_shop_flutter/UI/AcountUIComponent/myproducts.dart';
import 'package:treva_shop_flutter/UI/HomeUIComponent/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:treva_shop_flutter/UI/LoginOrSignup/Login.dart';
import 'package:treva_shop_flutter/constant.dart';

class bottomNavigationBar extends StatefulWidget {
  @override
  _bottomNavigationBarState createState() => _bottomNavigationBarState();
}

class _bottomNavigationBarState extends State<bottomNavigationBar> {
  int currentIndex = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  bool loggedin = false;

  getLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool('loggedin') != null) {
      setState(() {
        loggedin = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    final _pro = Provider.of<PoinBizProvider>(context, listen: true);
    return Scaffold(
      drawer: MyDrawer(
        log: loggedin,
      ),
      key: _key,
      body: Menu(
        scaKey: _key,
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  final bool log;

  MyDrawer({this.log});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SingleChildScrollView(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(

              image: DecorationImage(
                image: AssetImage("assets/img/Logo.png"),
                
                //
                //
                // )
                // ),
              ),
            ),
            child: Container(),
          ),

          // ListTile(
          //   leading: Icon(Icons.store),
          //   title: Text("Vendors Near Me"),
          //   onTap: () => Navigator.push(
          //       context, MaterialPageRoute(builder: (context) => AllVendors())),
          // ),
          ListTile(
            // onTap: () => Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => flashSale())),
            leading: Icon(Icons.inventory),
            title: Text("Add Product"),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => log ? AddProduct() : loginScreen())),
          ),
          Divider(),
          ListTile(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => !log ? loginScreen(): MyProducts())),
            leading: Icon(Icons.store),
            title: Text("My Products"),
            // onTap: () => Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => AllVendors())),
          ),
          Divider(),
          log
              ? ListTile(
                  onTap: () async {
                    EasyLoading.showInfo("Logging Out");
                    SharedPreferences sharedpref =
                        await SharedPreferences.getInstance();
                    sharedpref.remove("loggedin");
                    sharedpref.remove("data");
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            bottomNavigationBar()));
                    EasyLoading.dismiss();
                  },
                  leading: Icon(Icons.logout),
                  title: Text("Log Out"),
                  // onTap: () => Navigator.push(
                  //     context, MaterialPageRoute(builder: (context) => AllVendors())),
                )
              : ListTile(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => loginScreen())),
                  leading: Icon(Icons.login),
                  title: Text("Login"),
                  // onTap: () => Navigator.push(
                  //     context, MaterialPageRoute(builder: (context) => AllVendors())),
                ),

          // ListTile(
          //   onTap: () => Navigator.push(context,
          //       MaterialPageRoute(builder: (context) => PointTransfer())),
          //   leading: Icon(Icons.paid),
          //   title: Text("Point Transfer"),
          //   // onTap: () => Navigator.push(
          //   //     context, MaterialPageRoute(builder: (context) => AllVendors())),
          // ),
          // ListTile(
          //
          //   leading: Icon(Icons.policy),
          //   title: Text("Privacy Policy"),
          //   // onTap: () => Navigator.push(
          //   //     context, MaterialPageRoute(builder: (context) => AllVendors())),
          // ),
        ],
      ),
    ));
  }
}
