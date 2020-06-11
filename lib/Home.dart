import 'package:flutter/material.dart';
import 'ItemCard.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, dynamic> cart = {
    'total': 0,
  };
  void deleteCart() {
    cart.removeWhere((key, value) => key != 'total');
    countTotal();
  }

  void countTotal() {
    cart['total'] = 0;
    cart.forEach((key, value) {
      if (key != 'total') {
        cart['total'] += value['price'];
        print("cart total: " + cart['total'].toString());
        print(value['price'].toString());
      }
    });
  }

  void addItem(
      {@required String itemName,
      @required int itemCount,
      @required double itemPrice}) {
    setState(() {
      if (itemCount < 1) return;
      if (cart.containsKey(itemName)) {
        cart[itemName]['count'] = itemCount;
        cart[itemName]['price'] = itemPrice * itemCount;
      } else {
        cart[itemName] = {'count': 1, 'price': itemPrice};
      }
      countTotal();
    });
  }

  void removeItem(
      {@required String itemName,
      @required int itemCount,
      @required double itemPrice}) {
    setState(() {
      // if (itemCount < 1) return;
      if (cart.containsKey(itemName)) {
        if (cart[itemName]['count'] == 1) {
          cart.removeWhere((key, value) => key == itemName);
          countTotal();
          // cart.remove(itemName);
          return;
        }
        cart[itemName]['count'] = itemCount;
        cart[itemName]['price'] = itemPrice * itemCount;
      } else {
        return;
      }
      countTotal();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.card_travel),
          actions: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
              child: FlatButton(
                color: Colors.yellow,
                onPressed: () {},
                child: Icon(
                  Icons.call,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        body: Container(
          child: Column(
            children: [
              // cart
              Visibility(
                visible: cart['total'] > 0,
                child: Container(
                  height: 60,
                  color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        height: 40,
                        width: 60,
                        color: Colors.white,
                        child: FlatButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                          ),
                        ),
                      ),

                      // total price in cart
                      Container(
                        child: Row(
                          children: [
                            Text(cart['total'].toString()),
                            Text(" IQD"),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        height: 40,
                        width: 60,
                        color: Colors.lightBlue,
                        child: FlatButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.done,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // items
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ItemCard(
                      itemName: 'Zer fat',
                      currentPrice: 1500,
                      prevPrice: 2000,
                      add: addItem,
                      remove: removeItem,
                      imgUrl: 'assets/images/zer-fat.jpg',
                    ),
                    ItemCard(
                      itemName: 'Zer slim',
                      currentPrice: 2000,
                      add: addItem,
                      remove: removeItem,
                      imgUrl: 'assets/images/zer-slim.jpg',
                    ),
                  ],
                ),
              ),
              // Text(cart.toString(), style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
