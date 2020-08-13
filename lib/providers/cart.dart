

import 'package:flutter/foundation.dart';


class CartItems{
  final String id;
  final String title;
  final double price;
  final double quantity;
  CartItems({this.id,this.title,this.price,this.quantity});

}
class Cart with ChangeNotifier{
  Map<String,CartItems> _items={};
  Map<String,CartItems> get items{
    return {..._items};
  }
  int get itemCount{
    return _items.length;
  }
  double get totalAmount{
    var total =0.0;
   _items.forEach((key, value) {
      total += value.price * value.quantity;
      });
      return total;
  }
  void removeSingleItem(String productId){
  if(!_items.containsKey(productId)){
    return;
  }
  if(_items[productId].quantity > 1){
    _items.update(productId, (value) => CartItems(
      id: value.id,
      title: value.title,
      price: value.price,
      quantity: value.quantity
    )
    
    );
  }
  else{
    _items.remove(productId);
  }
  notifyListeners();
  }
  void addItem(String productId,double price,String title){
    if (_items.containsKey(productId)){
      _items.update(productId, (value) => CartItems(
        id: value.id,
        title: value.title,
        price: value.price,
        quantity: value.quantity+1
      ));
    }
    else{
      _items.putIfAbsent(productId, () => CartItems(
        id:DateTime.now().toString(),
        title: title,
        price: price,
        quantity: 1,
      ));
    }
    notifyListeners();
  }
  void removeItem(String productId){
    _items.remove(productId);
    notifyListeners();
  }
  void clear(){
    _items = {};
    notifyListeners();
  }
}