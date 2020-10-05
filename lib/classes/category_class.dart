class Category {
  Category({
    this.title,
    this.coverImage,
    this.items,
    this.description,
    this.food,
    this.pushScreen,
    this.content,
  });

  final String coverImage;
  final String title;
  final String description;
  final pushScreen;
  final content;
  List items;
  List food;
}
