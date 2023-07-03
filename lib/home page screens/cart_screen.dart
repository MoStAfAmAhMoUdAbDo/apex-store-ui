
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_items.dart';
import 'items.dart';

class My_basket extends StatelessWidget {
  const My_basket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart_Items>(
      builder: (context, provid, child) {
        if (provid.bascet_item.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: Text("عربه التسوق"),
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),
            body: Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.description_sharp),
                    Text(
                      "Empty cart",
                      style:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text("عربه التسوق"),
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    provid.remove_all_items();
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
            body: Column(
              children: [
                Flexible(
                  child: ListView.builder(
                    itemCount: provid.bascet_item.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Item new_item=provid.bascet_item[index];
                                    new_item.qty= ++new_item.qty;
                                    //provid.updat(index, new_item);
                                    provid.updat();
                                  },
                                  icon: Icon(Icons.add_circle_outline),
                                ),
                                Text("${provid.bascet_item[index].qty}"),
                                IconButton(onPressed: (){
                                  Item new_item=provid.bascet_item[index];
                                  new_item.qty= --new_item.qty;
                                  //provid.updat(index, new_item);
                                  provid.updat();
                                }, icon: Icon(Icons.do_not_disturb_on_outlined),),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("${provid.bascet_item[index].name}"),
                                  Text(" ${provid.bascet_item[index].price} السعر"),
                                  Text(
                                      "${provid.bascet_item[index].price * provid.bascet_item[index].qty}: المجموع الفرعي"),
                                  Row(
                                    children: [
                                      Text("مسح"),
                                      IconButton(
                                        onPressed: () {
                                          provid.remove_item(provid.bascet_item[index]);
                                        },
                                        icon: Icon(Icons.delete_sweep),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: ListTile(
                    title: Text("total price"),
                    trailing: Text("${provid.get_total_price()}"),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
