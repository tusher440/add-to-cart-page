import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_provider.dart';

class CartItems extends StatefulWidget {
 // const CartItems({Key? key}) : super(key: key);

  final int? index;
  final String? id;
  final String? productId;
  final String? name;
  final int? quantity;

  final double? price;
  final double? shipping;
  int qty;
  final String? imageUrl;
  CartItems({
    this.index,
    this.id,
    this.shipping,
    required this.qty,
    this.productId,
    this.price,
    this.quantity,
    this.name,
    this.imageUrl,
  });



  @override
  State<CartItems> createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      elevation: 5,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        ),
        subtitle: Text("Tk ${widget.price! * widget.qty}"),
        leading: Image.network(
          "${widget.imageUrl}",fit: BoxFit.fill,
        ),
        title: Text("${widget.name}",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),

        ),contentPadding: EdgeInsets.fromLTRB(4, 6, 0, 0),
        trailing: Container(
          height: 50,
          width: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                  child: Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(6)
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (widget.qty > 1) {
                                widget.qty--;
                                //final cart = Provider.of<Cart>(context,listen: false);
                                cart.setQty(
                                  ProductId: widget.productId,
                                  Price: widget.price,
                                  name: widget.name,
                                  qty: widget.qty,
                                  shipping: widget.shipping,
                                  imageUrl: widget.imageUrl,
                                );
                              }
                            });
                          },
                          child: Icon(Icons.remove),
                        ),
                        Text(
                          '${cart.items.values.toList()[widget.index!].qty}', //widget.qty
                          style: TextStyle(fontSize: 18),
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     setState(() {
                        //       widget.qty++;
                        //       // final cart = Provider.of<Cart>(context,listen: false);
                        //       cart.setQty(
                        //         productId: widget.productId,
                        //         Price: widget.price,
                        //         name: widget.name,
                        //         qty: widget.qty,
                        //         shipping: widget.shipping,
                        //         imageUrl: widget.imageUrl,
                        //       );
                        //     });
                        //   },
                        //   child: Icon(Icons.add),
                        // ),
                      ],
                    ),
              ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text('Are you sure?'),
                            content:
                            Text('Do you want to remove the item?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Text('NO'),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Provider.of<Cart>(context,
                                        listen: false)
                                        .reoveItem(widget.productId);
                                    Navigator.of(ctx).pop(true);
                                  },
                                  child: Text('Yes'))
                            ],
                          ));
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).errorColor,
                    )),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
