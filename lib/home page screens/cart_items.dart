import 'dart:ffi';

import 'package:flutter/cupertino.dart';

import 'items.dart';

class Cart_Items with ChangeNotifier {
  List<Item> _my_items = [];
  double _price = 0.0;
  int cart_count =0;

  void add_item(Item item) {
    if (_my_items.isEmpty) {
      _my_items.add(item);
      _price += item.units[0].salePrice1! * item.qty;
      notifyListeners();
    } else {
      int founded = _my_items.indexWhere((element) => element.id == item.id);
      if (founded != -1) {
        notifyListeners();
      } else {
        _my_items.add(item);
        _price += item.units[0].salePrice1! * item.qty;
        notifyListeners();
      }
    }
  }

  void updat() {
    notifyListeners();
  }

  int get_cart_count() {
    return _my_items.length;
  }

  double get_total_price() {
    double x = 0;
    for (int i = 0; i < _my_items.length; i++) {
      x += (_my_items[i].units[0].salePrice1! * _my_items[i].qty);
    }
    _price = x;
    return _price;
  }

  void remove_item(Item item) {
    List<Item> removed_tiem = [];
    bool x = false;
    for (Item val in _my_items) {
      if (item.id == val.id) {
        removed_tiem.add(val);
        x = true;
      }
    }
    if (!removed_tiem.isEmpty) {
      for (Item data in removed_tiem) {
        _price -= data.units[0].salePrice1!;
        _my_items.remove(data);
      }
      notifyListeners();
    }
    removed_tiem.clear();
    notifyListeners();
  }

  void remove_all_items() {
    _my_items.clear();
    notifyListeners();
  }

  List<Item> get bascet_item {
    return _my_items;
  }

  List<Item> update_my_list(List<Item> saved){
    if(_my_items.isEmpty){
      return saved ;
    }
    else{
      List<Item> new_list =[];
      for(Item item in _my_items){
        for(Item i in saved){
          if(item.id==i.id){
            new_list.add(item);
            break;
          }
        }
      }
      return new_list;
    }

  }

// List<Item> _saved_list =[];
// void save_my_list(List<Item> saved){
//   _saved_list.clear();
//   _saved_list.addAll(saved);
// }
// List<Item> get_saved_list(){
//   return _saved_list ;
// }
}
