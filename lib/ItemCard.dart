import 'package:flutter/material.dart';



class ItemCard extends StatefulWidget {
  final String itemName;
  final double currentPrice;
  final double prevPrice;
  final Function(
      {@required String itemName,
      @required int itemCount,
      @required double itemPrice}) add;
  final Function(
      {@required String itemName,
      @required int itemCount,
      @required double itemPrice}) remove;
  final String imgUrl;
  ItemCard(
      {@required this.itemName,
      @required this.currentPrice,
      this.prevPrice = -1,
      @required this.add,
      @required this.remove,
      @required this.imgUrl})
      : assert(add != null &&
            remove != null &&
            currentPrice >= 0 &&
            currentPrice != null &&
            imgUrl != null);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  int itemCount = 0;
  Widget addPrevPrice() {
    if (widget.prevPrice == -1) return Container();

    return Text(
      widget.prevPrice.toString(),
      style: TextStyle(
          decoration: TextDecoration.lineThrough, color: Colors.yellow),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: 300,
      decoration: BoxDecoration(
          color: Colors.white,
          // border: Border.all(),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
            )
          ]),
      child: Column(
        children: [
          // header
          Container(
            height: 40,
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                addPrevPrice(),
                Text(
                  widget.currentPrice.toString(),
                ),
                Visibility(
                  visible: (itemCount > 0),
                  child: Container(
                    // padding: EdgeInsets.all(3),
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Center(
                        child: Text(
                      itemCount.toString(),
                      style: TextStyle(color: Colors.black),
                    )),
                  ),
                ),
              ],
            ),
          ),
          // image
          Flexible(
            child: Image.asset(widget.imgUrl),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "1Kg",
                style: TextStyle(color: Colors.black),
              ),
              Text(
                "ئالتونسا",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          Divider(
            color: Colors.grey,
          ),
          // buttons
          Container(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (itemCount > 0) {
                          itemCount--;
                        }
                        
                        print(itemCount);
                        widget.remove(
                          itemCount: itemCount,
                          itemName: widget.itemName,
                          itemPrice: widget.currentPrice,
                        );
                      });
                    },
                    child: Icon(
                      Icons.remove,
                      color: Colors.black,
                    ),
                  ),
                ),
                Visibility(
                  visible: (itemCount > 0),
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.symmetric(
                          horizontal: BorderSide(color: Colors.grey),
                        )),
                        child: Center(
                          child: Text(
                            (itemCount * widget.currentPrice).toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        itemCount++;
                        widget.add(
                          itemCount: itemCount,
                          itemName: widget.itemName,
                          itemPrice: widget.currentPrice,
                        );
                      });
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
