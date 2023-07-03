import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_items.dart';
import 'cart_screen.dart';
import 'items.dart';
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
  List<Item> my_cart = [
    Item(name: "s22", id: 1, price: 22, cpu_version: "8core", in_stock: 50),
    Item(name: "s23", id: 2, price: 23, cpu_version: "7core", in_stock: 50),
    Item(name: "s24", id: 3, price: 22, cpu_version: "8core", in_stock: 50),
    Item(name: "s25", id: 4, price: 22, cpu_version: "8core", in_stock: 50),
    Item(name: "s26", id: 5, price: 22, cpu_version: "8core", in_stock: 50),
    Item(name: "s7", id: 6, price: 22, cpu_version: "8core", in_stock: 50),
    Item(name: "s5", id: 7, price: 22, cpu_version: "8core", in_stock: 50),
    Item(name: "s9", id: 8, price: 22, cpu_version: "8core", in_stock: 50),
    Item(name: "s11", id: 9, price: 22, cpu_version: "8core", in_stock: 50),
    Item(name: "s10", id: 10, price: 22, cpu_version: "8core", in_stock: 50)
  ];
  List<Item> new_listsearch = [];
  bool isconvert = true;
  GlobalKey<ScaffoldState> _globalkey = new GlobalKey<ScaffoldState>();
  int shopping_cart_count = 0;
  int qty_menue_count = 0;
  int price_menue_count = 0;
  TextEditingController txt_price_controler = TextEditingController();
  TextEditingController txt_value_controler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //on_search();
    var result = ModalRoute.of(context)!.settings.arguments;
    TextEditingController textController = TextEditingController();
    return Scaffold(
        floatingActionButton: FloatingActionButton.large(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          tooltip: "added to the card",
          onPressed: () {
            //HapticFeedback.vibrate();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => My_basket()));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart_rounded),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Consumer<Cart_Items>(
                    builder: (context, prov, child) {
                      return Text(
                        "${prov.get_cart_count()}.0",
                        style: TextStyle(color: Colors.black),
                      );
                    },
                  )),
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
              onPressed: () async {
                Navigator.pushReplacementNamed(context, Qr_scanner.rout);
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => Qr_scanner()));
                setState(() {});
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
          body: SingleChildScrollView(
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
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: new_listsearch.length,
        // physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, i) {
          return Card(
            color: Colors.grey,
            child: ListTile(
              onTap: () {
                print(
                    "the list of provider is ${Provider.of<Cart_Items>(context, listen: false).bascet_item.isEmpty ? "is empty " : "is not empty"}");
                txt_value_controler.text = new_listsearch[i].qty.toString();
                txt_price_controler.text = new_listsearch[i].price.toString();
                showDialog(
                    context: context, builder: (context) => Custom_dialog(i));
              },
              title: Text("${new_listsearch[i].name}"),
              subtitle: Text("${new_listsearch[i].price}"),
              trailing: Text("${new_listsearch[i].cpu_version}"),
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
          return Consumer<Cart_Items>(
            builder: (context, prov, child) {
              return Card(
                child: ListTile(
                  onTap: () {
                    txt_value_controler.text = new_listsearch[i].qty.toString();
                    txt_price_controler.text =
                        new_listsearch[i].price.toString();
                    showDialog(
                        context: context,
                        builder: (context) => Custom_dialog(i));
                  },
                  title: Text("${new_listsearch[i].name}"),
                  subtitle: Text("${new_listsearch[i].price}"),
                  trailing: Text("${new_listsearch[i].cpu_version}"),
                ),
              );
            },
          );
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
        if (item.name.toLowerCase().contains(searchValue.toString())) {
          new_listsearch.add(item);
          //print("the value in new list is ${new_listsearch[0]}");
        }
      }
    }
  }

  InputDecoration text_field_style() {
    return InputDecoration(
        filled: true,
        fillColor: Colors.grey[400],
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black26),
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(25),
        ));
  }

  Widget Custom_dialog(int i) {
    int count = 0;
    return Consumer<Cart_Items>(
      builder: (context, provid, child) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            height: 390,
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      color: Colors.indigo,
                    ),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      "${my_cart[i].name}",
                      style: TextStyle(fontSize: 50),
                    )),
                Container(
                  height: 190,
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
                        padding: const EdgeInsets.only(top: 35),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 37,
                            ),
                            IconButton(
                                onPressed: () {
                                  count = int.parse(
                                      txt_value_controler.text.toString());
                                  txt_value_controler.text =
                                      (++count).toString();
                                },
                                icon: Icon(Icons.add_circle, size: 50)),
                            SizedBox(
                              width: 25,
                            ),
                            Container(
                              width: 50,
                              child: TextFormField(
                                controller: txt_price_controler,
                                textAlign: TextAlign.center,
                                decoration: text_field_style(),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            IconButton(
                                onPressed: () {
                                  count = int.parse(
                                      txt_value_controler.text.toString());
                                  txt_value_controler.text =
                                      (--count).toString();
                                },
                                icon: Icon(
                                  Icons.do_not_disturb_on,
                                  size: 50,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
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
                          onPressed: () {
                            my_cart[i].qty =
                                int.parse(txt_value_controler.text);
                            provid.add_item(my_cart[i]);
                            print(
                                "the total count of list in daialog is : ${provid.get_cart_count()}");
                            Navigator.pop(context);
                          },
                          child: Text("confirm")),
                    ),
                    SizedBox(
                      height: 50,
                      width: 110,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("cancel")),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
