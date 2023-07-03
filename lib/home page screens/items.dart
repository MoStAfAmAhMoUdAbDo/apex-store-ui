

class Item{
  String? arabName;
  String? latinName;
  String? imageUrl;
  int? id;
  bool? applyVAT;
  double? vatRatio;
  String? itemCode;
  List<Unit> units;
  int qty=1 ;
  int? itemTypeId ;
  Item(this.latinName,this.arabName,this.id,this.applyVAT,this.imageUrl,this.itemCode,this.vatRatio,this.units ,this.itemTypeId);
  factory  Item.fromjson(Map<String,dynamic>json){
    List<Unit> temp=[];
    for (var c in json['units']) {
      temp.add(Unit.fromjson(c));
    }
    return Item(
      json["latinName"],
      json["arabicName"],
      json["id"],
      json["applyVAT"],
      json["imagePath"],
      json["itemCode"],
      json["vatRatio"],
      temp,
      json["itemTypeId"],
    );
  }
}

class Unit{
  int? unitId;
  String? arabName;
  String? latinName;
  double? conversionFactor ;
  double? salePrice1;
  Unit(this.arabName,this.conversionFactor,this.latinName,this.salePrice1,this.unitId);

  factory Unit.fromjson(Map<String,dynamic>json){
    return Unit(
      json["arabicName"],
      json["conversionFactor"],
      json["latinName"],
      json["salePrice1"],
      json["unitId"],
    );
  }
}



