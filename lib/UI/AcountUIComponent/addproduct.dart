import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/API/provider_class.dart';
import 'package:treva_shop_flutter/constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:treva_shop_flutter/sharedPref/savedinfo.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _stock = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _description = TextEditingController();
  PickedFile _image;
  String cat = "";
  final ImagePicker _picker = ImagePicker();

  void pickImageFromCamera() async {
    final PickedFile pickedFile =
    await _picker.getImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image = pickedFile;
    });
    Navigator.pop(context);
  }

  void pickImageFromGallery() async {
    final PickedFile pickedFile =
    await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image = pickedFile;
    });

    Navigator.pop(context);
  }

  void showImagePickerModal() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(20),
            height: 160,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                const Text(
                  "Image Pick Options",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => pickImageFromCamera(),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: appColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Text(
                                "Open camera",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              Icon(
                                Icons.camera,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: appColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: GestureDetector(
                          onTap: () => pickImageFromGallery(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Text(
                                "Open Gallery",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              Icon(
                                Icons.image,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }



  void addProduct()async{
    final userId = await UserData.getUserId();
    EasyLoading.show(status: "Creating Product");
    print(userId);
    final Map<String, String> data = {
      "category":cat,
      "name": _name.text,
      "description": _description.text,
      "stock": _stock.text,
      "price": _price.text,
      "id": userId.toString()
    };
   final response = http.MultipartRequest("POST", Uri.parse(base_url + "products/create/"));

   response.files.add(await http.MultipartFile.fromPath('image', _image.path));
   response.fields.addAll(data);

    var streamedResponse = await response.send();
    var res = await http.Response.fromStream(streamedResponse);
    EasyLoading.dismiss();
    if (res.statusCode < 206){
      EasyLoading.showSuccess(json.decode(res.body)['message']);
      Navigator.pop(context);
    }
    else{

      EasyLoading.showError("Sorry, try again later!");
    }


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _name.dispose();
    _stock.dispose();
    _price.dispose();
    _description.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final _pro = Provider.of<PoinBizProvider>(context, listen: false);
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    mediaQueryData.devicePixelRatio;
    mediaQueryData.size.height;
    mediaQueryData.size.width;
    return Scaffold(

      appBar: AppBar(
        backgroundColor: appColor,
        centerTitle: true,
        title: Text("Post Product", style: TextStyle(color: Colors.white),),
        leading: InkWell(
            onTap: ()=>Navigator.pop(context),
            child: Icon(Icons.arrow_back, color: Colors.white,)),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              /// Set Background image in layout
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/img/backgroundgirl.png"),
                    fit: BoxFit.cover,
                  )),
              child: Container(
                /// Set gradient color in image
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(0, 0, 0, 0.2),
                      Color.fromRGBO(0, 0, 0, 0.3)
                    ],
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                  ),
                ),
                /// Set component layout
                child: ListView(
                  padding: EdgeInsets.all(0.0),
                  children: <Widget>[
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: <Widget>[
                        Column(
                          children: <Widget>[

                            Container(
                              alignment: AlignmentDirectional.topCenter,
                              child: Column(
                                children: <Widget>[
                                  /// padding logo
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top:
                                          mediaQueryData.padding.top + 25.0)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image(
                                        image: AssetImage("assets/img/Logo.png"),
                                        height: 70.0,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0)),
                                      /// Animation text treva shop accept from login layout
                                      Hero(
                                        tag: "Treva",
                                        child: Text(
                                          "Adom",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              letterSpacing: 0.6,
                                              fontFamily: "Sans",
                                              color: Colors.white,
                                              fontSize: 20.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                      padding:
                                      EdgeInsets.symmetric(vertical: 30.0)),
                                  /// TextFromField Email


                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [


                                        ///FIRST NAME
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                                          child: Container(

                                            alignment: AlignmentDirectional.center,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(14.0),
                                                color: Colors.white,
                                                boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]),
                                            padding:
                                            EdgeInsets.only(top: 0.0, bottom: 0.0),
                                            child: Theme(
                                              data: ThemeData(
                                                hintColor: Colors.transparent,
                                              ),
                                              child: DropdownSearch<Map>(
                                                mode: Mode.BOTTOM_SHEET,
                                                label: "Category",
                                                hint: "Select item category",
                                                items: [for (var a in _pro.allcategories) a],
                                                itemAsString: (Map u) => u['name'],
                                                onChanged: (Map data) {
                                                  setState(() {
                                                    if (data != null) {
                                                      cat = data['id'].toString();
                                                    } else {
                                                      cat = "";
                                                    }
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                            padding:
                                            EdgeInsets.symmetric(vertical: 5.0)),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                                          child: Container(

                                            alignment: AlignmentDirectional.center,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(14.0),
                                                color: Colors.white,
                                                boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]),
                                            padding:
                                            EdgeInsets.only(left: 20.0, right: 30.0, top: 0.0, bottom: 0.0),
                                            child: Theme(
                                              data: ThemeData(
                                                hintColor: Colors.transparent,
                                              ),
                                              child: TextFormField(
                                                controller: _name,
                                                validator: (e){
                                                  if(_name.text.isEmpty){
                                                    return "Please enter product name";
                                                  }
                                                  else{
                                                    return null;
                                                  }
                                                },
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    labelText: "Product Name",

                                                    labelStyle: TextStyle(
                                                        fontSize: 15.0,
                                                        fontFamily: 'Sans',
                                                        letterSpacing: 0.3,
                                                        color: Colors.black38,
                                                        fontWeight: FontWeight.w600)),
                                                keyboardType: TextInputType.text,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                            padding:
                                            EdgeInsets.symmetric(vertical: 5.0)),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                                          child: Container(

                                            alignment: AlignmentDirectional.center,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(14.0),
                                                color: Colors.white,
                                                boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]),
                                            padding:
                                            EdgeInsets.only(left: 20.0, right: 30.0, top: 0.0, bottom: 0.0),
                                            child: Theme(
                                              data: ThemeData(
                                                hintColor: Colors.transparent,
                                              ),
                                              child: TextFormField(
                                                controller: _stock,
                                                validator: (e){
                                                  if(_stock.text.isEmpty){
                                                    return "Please enter stock available";
                                                  }
                                                  else{
                                                    return null;
                                                  }
                                                },
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    labelText: "Stock Available",

                                                    labelStyle: TextStyle(
                                                        fontSize: 15.0,
                                                        fontFamily: 'Sans',
                                                        letterSpacing: 0.3,
                                                        color: Colors.black38,
                                                        fontWeight: FontWeight.w600)),
                                                keyboardType: TextInputType.number,
                                              ),
                                            ),
                                          ),
                                        ),

                                        Padding(
                                            padding:
                                            EdgeInsets.symmetric(vertical: 5.0)),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                                          child: Container(

                                            alignment: AlignmentDirectional.center,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(14.0),
                                                color: Colors.white,
                                                boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]),
                                            padding:
                                            EdgeInsets.only(left: 20.0, right: 30.0, top: 0.0, bottom: 0.0),
                                            child: Theme(
                                              data: ThemeData(
                                                hintColor: Colors.transparent,
                                              ),
                                              child: TextFormField(
                                                controller: _price,
                                                validator: (e){
                                                  if(_price.text.isEmpty){
                                                    return "Please enter price of the product";
                                                  }
                                                  else{
                                                    return null;
                                                  }
                                                },
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    labelText: "Product Price",

                                                    labelStyle: TextStyle(
                                                        fontSize: 15.0,
                                                        fontFamily: 'Sans',
                                                        letterSpacing: 0.3,
                                                        color: Colors.black38,
                                                        fontWeight: FontWeight.w600)),
                                                keyboardType: TextInputType.number,
                                              ),
                                            ),
                                          ),
                                        ),



                                        ///OTHER NAMES

                                        Padding(
                                            padding:
                                            EdgeInsets.symmetric(vertical: 5.0)),

                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                                          child: Container(

                                            alignment: AlignmentDirectional.center,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(14.0),
                                                color: Colors.white,
                                                boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]),
                                            padding:
                                            EdgeInsets.only(left: 20.0, right: 30.0, top: 0.0, bottom: 0.0),
                                            child: Theme(
                                              data: ThemeData(
                                                hintColor: Colors.transparent,
                                              ),
                                              child: TextFormField(
                                                controller: _description,
                                                maxLines: 6,
                                                validator: (e){
                                                  if(_description.text.isEmpty){
                                                    return "Please enter product description";
                                                  }
                                                  else{
                                                    return null;
                                                  }
                                                },
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    labelText: "Product Description",

                                                    labelStyle: TextStyle(
                                                        fontSize: 15.0,
                                                        fontFamily: 'Sans',
                                                        letterSpacing: 0.3,
                                                        color: Colors.black38,
                                                        fontWeight: FontWeight.w600)),
                                                keyboardType: TextInputType.text,
                                              ),
                                            ),
                                          ),
                                        ),



                                        Padding(
                                            padding:
                                            EdgeInsets.symmetric(vertical: 5.0)),

                                        Card(
                                          elevation: 6,
                                          child: Container(
                                            height: 180,
                                            color: Colors.white,
                                            child: Stack(
                                              children: [
                                                _image == null
                                                    ? const Center(
                                                  child: Text(
                                                    "Image of product*\nNo image selected.",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                )
                                                    : Container(
                                                    width: double.infinity,
                                                    child: Image.file(
                                                      File(_image.path),
                                                      fit: BoxFit.cover,
                                                    )),
                                                Positioned(
                                                    right: 10,
                                                    top: 10,
                                                    child: GestureDetector(
                                                      onTap: () => showImagePickerModal(),
                                                      child: Card(
                                                        color: appColor,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(7)),
                                                        child: const Padding(
                                                          padding: EdgeInsets.all(10),
                                                          child: Icon(
                                                            Icons.camera_alt,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                            padding:
                                            EdgeInsets.symmetric(vertical: 20.0)),

                                        InkWell(
                                          onTap: (){
                                            if(_formKey.currentState.validate()){
                                              if(_image != null && cat.isNotEmpty){
                                                addProduct();
                                              }
                                            }
                                          },
                                          child: Card(
                                            elevation: 10,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: _image != null && cat.isNotEmpty ? appColor:Colors.grey,
                                                borderRadius: BorderRadius.all(Radius.circular(5))
                                              ),
                                              width: 90,
                                              height: 50,
                                              child: Center(child: Text("Add Product", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                                            ),
                                          ),
                                        )







                                      ],
                                    ),
                                  ),
                                  /// Button Login
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: mediaQueryData.padding.top + 30.0,
                                        bottom: 0.0),
                                  ),







                                ],
                              ),
                            ),
                          ],
                        ),

                        /// Set Animaion after user click buttonLogin

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
