//This Widget gives the format of the products that are in this app for sale.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../providers/products_provider.dart';
class UserItems extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  UserItems(this.id,this.title,this.imageUrl);
  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(children: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            color: Colors.grey,
            onPressed: (){
              Navigator.of(context).pushNamed(EditProductScreen.routeName,arguments: id);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            color: Colors.red,
            onPressed: () async {
              try{
              await Provider.of<Products>(context,listen: false).deleteProduct(id);
              }catch(error){
                scaffold.showSnackBar(
                  SnackBar(content: Text('Oops, Product not Deleted!!!'),)
                );
              }
            },
          )
        ],),
      ),
    );
  }
}