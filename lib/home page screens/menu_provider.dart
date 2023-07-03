
import 'package:flutter/cupertino.dart';

class menuProviderOptions with ChangeNotifier {
  bool _enablePopup =false;
  bool _disableImage =false;
  bool get enablePopup => _enablePopup;
  bool get disableImage => _disableImage;
  void changePopupData(bool val){
    _enablePopup = val;
    notifyListeners();
  }
  void changeImageData(bool val){
    _disableImage = val;
    notifyListeners();
  }

}