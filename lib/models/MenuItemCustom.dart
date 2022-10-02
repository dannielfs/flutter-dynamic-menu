class MenuItemCustom {
  final String title;
  final int id;

  MenuItemCustom({required this.title, required this.id});

  factory MenuItemCustom.fromJson(Map<String, dynamic> json) {
    return MenuItemCustom(title: json['title'], id: json['id']);
  }
}
