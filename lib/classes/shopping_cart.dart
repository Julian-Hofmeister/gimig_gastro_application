class Cart {
  Cart({this.shoppingList, this.orderedList});
  final List shoppingList;
  List orderedList;
}

Cart shoppingCart = Cart(
  shoppingList: [],
  orderedList: [],
);
