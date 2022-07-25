import 'package:flutter/material.dart';

class CartItem{
  final int quantity;
  final String? productId;
  final String name;
  final String imageUrl;
  final double price;
  final Option option;
  int? qty;

  CartItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    required this.option,
    this.qty,
});
}

class Option{
  String? color;
  String? size;
  int? vat;
  Option({this.color,this.size,this.vat});
}

class Cart with ChangeNotifier{
  Map<String,CartItem>_items ={};
  Map<String,CartItem>get items {
    return{..._items};

  }
  int get itemCount{
    return _items.length;

  }


  void setQty({String?ProductId,double? Price,double?shipping, String? name,String?imageUrl,int?qty, String? productId}){
    _items.update(ProductId??"",(exittingItem) => CartItem(
      productId: ProductId,
      name: name??"",
      price: Price?? 0.0,
      quantity: qty??1,
      imageUrl: imageUrl??"",
      qty: qty??1,
      option: Option(
        color: "red",
            size: "S",
        vat: 10,
      )
    ),
    );
    notifyListeners();
}
  void addItem(String productId, double price,
      String? name, String? imageUrl, int qty){
    if(_items.containsKey(productId)){
      _items.update(
        productId!,
      (exittingItem) =>CartItem(
          productId: exittingItem.productId,
          name: name??"",
          price: price?? 0.0,
          quantity: qty??1,
          imageUrl: imageUrl??"",
          qty: qty??1,
          option: Option(
            color: "red",
            size: "S",
            vat: 10,
          ) )      );
    }
    else{
      _items.putIfAbsent(
          productId!,
              () => CartItem(
            name: name!,
            productId: productId,
            price: price,
            quantity: qty,
            imageUrl: imageUrl!,
            qty: qty,
            option: Option(
              color: "red",
              size: "S",
              vat: 10,
            ),
          ));

    }
    notifyListeners();
  }


  double get totalAmount {
    var total = 0.0;
    total = subAmount + 50;

    return total;
  }

  double get subAmount {
    var subtotal = 0.0;

    _items.forEach((key, cartItem) {
      subtotal += (cartItem.price * cartItem.qty!.toInt());
    });
    return subtotal;
  }

  void reoveItem(String? productId){
    _items.remove(productId);
    notifyListeners();
  }
  void clearCart(){
    _items ={};
    notifyListeners();
  }

}