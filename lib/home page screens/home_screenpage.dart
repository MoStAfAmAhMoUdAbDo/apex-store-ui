import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../api_directory/get_home_data.dart';
import '../api_directory/login_api.dart';
import 'cart_items.dart';
import 'cart_screen.dart';
import 'items.dart';
import 'menu_provider.dart';
import 'qr_scanner.dart';
import 'package:flutter/services.dart';

class home_screen extends StatefulWidget {
  const home_screen({Key? key}) : super(key: key);
  static const rout = '/home_screen';
  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  var searchValue;

  List<Item> my_cart=[];
  List<Item> new_listsearch = [];
  bool isconvert = true;
  GlobalKey<ScaffoldState> _globalkey = new GlobalKey<ScaffoldState>();
  int shopping_cart_count = 0;
  int  qty_menue_count=0;
  int  price_menue_count=0;
  TextEditingController txt_price_controler =TextEditingController();
  TextEditingController txt_value_controler=TextEditingController();

  late ScrollController _scrollController;
  bool isLoadMore=false;
  int pageNumber = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHomeData().getCategoryData(pageNumber).then((value) {
      setState(() {
        my_cart.addAll(value);
      });
    });
    _scrollController=ScrollController();
    _scrollController.addListener(_scrollLisner);


  }
  // void didChangeDependencies() {
  //   getHomeData().getCategoryData().then((value) {
  //     setState(() {
  //       my_cart = value;
  //     });
  //   });
  // }
  Future<void> _scrollLisner()async{
    print("postion pixel ${_scrollController.position.pixels}");
    print("maxscrol pixel ${_scrollController.position.maxScrollExtent}");
    if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 1200.0){
      setState(() {
        isLoadMore =true;
      });


      pageNumber ++ ;
      await getHomeData().getCategoryData(pageNumber).then((value) {
        my_cart.addAll(value);
      });

      setState(() {
        isLoadMore=false;
      });
    }
  }
  var result;
  int x=0;
  @override
  Widget build(BuildContext context) {
    //var result = ModalRoute.of(context)!.settings.arguments;
    //TextEditingController textController = TextEditingController();
    // print("the bool value of image is ${Provider.of<menuProviderOptions>(context).disableImage}");
    // print ("the value of token is ${loginapi.token}");
    print ("the value  of qr scan is $result num${x++}");
    return Scaffold(
        floatingActionButton: FloatingActionButton.large(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          tooltip: "added to the card",
          onPressed: () {
            //HapticFeedback.vibrate();
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>My_basket()));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart_rounded),

              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white
                  ),
                  child:Consumer<Cart_Items>(builder: (context,prov,child){
                    return Text("${prov.get_cart_count()}.0",style: TextStyle(color: Colors.black),);
                  },)
              ),
            ],
          ),
        ),
        appBar: EasySearchBar(
          title: const Text('الصفحه الرسميه'),
          onSearch: (value) {
            setState(() {
              searchValue = value;
              print("the search value is ${searchValue}");
            });
          },
          //suggestions: _suggestions,

          leading: Navigator.of(context).canPop()
              ? null
              : IconButton(
            onPressed: () {
              if (_globalkey.currentState!.isDrawerOpen == false) {
                setState(() {
                  _globalkey.currentState!.openDrawer();
                });
              }
            },
            icon: Icon(Icons.dehaze),
          ),
          actions: [
            IconButton(
              onPressed: ()async{
               result=await Navigator.pushNamed(context, Qr_scanner.rout);
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => Qr_scanner()));
                setState(() {

                });
              },
              icon: const Icon(
                Icons.qr_code_scanner_outlined,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  isconvert = !isconvert;
                });
                // print("in grid btn isconvert is : ${isconvert}");
              },
              icon: const Icon(
                Icons.grid_on_outlined,
              ),
            ),
          ],
        ),
        body: Scaffold(
          key: _globalkey,
          drawer: Drawer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("التصنيفات"),
                Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.description_sharp,
                        color: Colors.indigo,
                      ),
                      Text(
                        "No Categories",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      //here some change
                      Navigator.of(context).pop();
                      //Navigator.pushReplacementNamed(context, Main_Screen.rout);
                    },
                    child: Center(
                      child: Text("جميع المنتجات"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body:my_cart.isEmpty? Container(color: Colors.white,
            child: Center(child: CircularProgressIndicator()),
          ):
          SingleChildScrollView(
            controller: _scrollController,
            physics: BouncingScrollPhysics(),
            child: Container(
              color: Colors.amber,
              child: Center(
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        "the result of scanning is  ${result.toString()}",
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      cheack(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));

  }

  Widget Gridview_convert() {
    on_search();
    return GridView.builder(
      // controller: _scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisSpacing:10, crossAxisSpacing: 10),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: new_listsearch.length,
        // physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, i) {
          return InkWell(
            onTap: (){
              txt_value_controler.text =new_listsearch[i].qty.toString();
              txt_price_controler.text =new_listsearch[i].units[0].salePrice1.toString();
              showDialog(context: context, builder: (context)=> Custom_dialog( i ));
            },
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: FittedBox(
                      child:new_listsearch[i].imageUrl == null ?CircleAvatar(child: Text(new_listsearch[i].itemTypeId.toString()),)  : Image.network(new_listsearch[i].imageUrl.toString()),
                    ),
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 20,
                      child: Text("${new_listsearch[i].latinName}")),
                  Text("${new_listsearch[i].units[0].salePrice1}"),
                ],
              ),
            ),
          );
        });
  }

  Widget ListTile_convert() {
    on_search();
    return ListView.builder(

        itemCount: new_listsearch.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, i) {
          // if(i >= new_listsearch.length){
          //   return Center(child: CircularProgressIndicator());
          // }
          //   else{
          return Consumer<Cart_Items>(builder: (context,prov ,child){
            return Card(
              child: Consumer<menuProviderOptions>(builder: (context,pro,child){
                if(pro.disableImage==false){
                  return ListTile(
                    onTap: () {
                      //print("the list of provider is ${Provider.of<Cart_Items>(context,listen: false).bascet_item.isEmpty ? "is empty " : "is not empty"}");
                      if(pro.enablePopup ==true){
                        txt_value_controler.text =new_listsearch[i].qty.toString();
                        txt_price_controler.text =new_listsearch[i].units[0].salePrice1.toString();
                        showDialog(context: context, builder: (context)=> Custom_dialog( i ));
                      }
                      else{
                        prov.add_item(my_cart[i]);
                      }

                    },
                    title: Text("${new_listsearch[i].latinName}"),
                    subtitle: Text("${new_listsearch[i].units[0].salePrice1}"),
                    trailing: CircleAvatar(

                        child: new_listsearch[i].imageUrl == null ? Text(new_listsearch[i].itemTypeId.toString()) : Image.network(new_listsearch[i].imageUrl.toString())  ),
                  );
                }
                else{
                  return ListTile(
                    onTap: () {
                      //print("the list of provider is ${Provider.of<Cart_Items>(context,listen: false).bascet_item.isEmpty ? "is empty " : "is not empty"}");
                      if(pro.enablePopup ==true){
                        txt_value_controler.text =new_listsearch[i].qty.toString();
                        txt_price_controler.text =new_listsearch[i].units[0].salePrice1.toString();
                        showDialog(context: context, builder: (context)=> Custom_dialog( i ));
                      }
                      else{
                        prov.add_item(my_cart[i]);
                      }
                    },
                    title: Text("${new_listsearch[i].latinName}"),
                    subtitle: Text("${new_listsearch[i].units[0].salePrice1}"),
                  );
                }
              },),
            );
          },);
          //}
        });
  }

  Widget cheack() {
    if (isconvert) {
      return ListTile_convert();
    } else
      return Gridview_convert();

  }

  on_search() {
    //print("in search fn ");
    if (searchValue == null) {
      new_listsearch.clear();
      for (var item in my_cart) {
        new_listsearch.add(item);
      }

    }
    if (searchValue != null) {
      new_listsearch.clear();
      for (var item in my_cart) {
        if (item.latinName!.toLowerCase().contains(searchValue.toString())) {
          new_listsearch.add(item);
          //print("the value in new list is ${new_listsearch[0]}");
        }
      }
    }
  }




  InputDecoration text_field_style(){
    return InputDecoration(
        filled: true,
        fillColor: Colors.grey[400],

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black26),
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black ,width: 2),
          borderRadius: BorderRadius.circular(25),
        ));
  }


  Widget Custom_dialog(int i ){
    int count=0;
    return  Consumer<Cart_Items>(builder: (context,provid,child){
      //print("the lengh of name is ${my_cart[i].latinName!.substring(0,20)}");
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          height: 500,
          child: Column(
            children: [
              Container(
                height: 100,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(5) ,topRight:Radius.circular(5), ),
                  color: Colors.indigo,
                ),
                alignment:Alignment.center,
                child: Center(child:my_cart[i].latinName!.length >9?
                Text(my_cart[i].latinName!.substring(0,9).toString(),style: TextStyle(fontSize: 50),):
                Text(my_cart[i].latinName.toString(),style: TextStyle(fontSize: 50),),),),

              Container(
                padding: EdgeInsets.only(top: 40),
                height: 230,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("سعر الوحده"),
                        // SizedBox(width: 100,),
                        Text("القيمه"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 100,
                          child: TextFormField(
                            controller: txt_price_controler,
                            textAlign: TextAlign.center,
                            decoration: text_field_style(),
                          ),
                        ),
                        Container(
                          width: 100,
                          child: TextFormField(

                            controller: txt_value_controler,
                            decoration: text_field_style(),
                            textAlign: TextAlign.center,

                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 37,),
                          IconButton(onPressed: (){
                            count=int.parse(txt_value_controler.text.toString());
                            txt_value_controler.text=(++count).toString();

                          }, icon: Icon(Icons.add_circle,size: 50)),
                          SizedBox(width: 25,),
                          Container(
                            width: 60,
                            child: TextFormField(
                              controller: txt_price_controler,
                              textAlign: TextAlign.center,
                              decoration: text_field_style(),
                            ),
                          ),
                          SizedBox(width: 5,),
                          IconButton(onPressed: (){
                            count=int.parse(txt_value_controler.text.toString());
                            txt_value_controler.text=(--count).toString();
                          }, icon: Icon(Icons.do_not_disturb_on,size: 50,)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 100,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 50,
                    width: 110,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                        ),
                        onPressed: (){
                          my_cart[i].qty=int.parse(txt_value_controler.text);
                          provid.add_item(my_cart[i]);
                          print("the total count of list in daialog is : ${provid.get_cart_count()}");
                          Navigator.pop(context);
                        }, child: Text("confirm")),
                  ),
                  SizedBox(
                    height: 50,
                    width: 110,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                        }, child:  Text("cancel")),
                  ),
                ],
              ),

            ],
          ),
        ),
      );
    },);
  }


}

