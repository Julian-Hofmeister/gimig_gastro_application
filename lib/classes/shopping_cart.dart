class Cart {
  Cart({this.shoppingList, this.orderdList});
  final List shoppingList;
  List orderdList;
}

Cart shoppingCart = Cart(
  shoppingList: [],
  orderdList: [],
);
