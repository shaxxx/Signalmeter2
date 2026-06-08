import 'package:flutter/widgets.dart';

@immutable
class MenuItem {
  const MenuItem({
    required this.title,
    required this.icon,
    required this.key,
  });

  final String title;
  final IconData icon;
  final String key;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuItem &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          icon == other.icon &&
          key == other.key;

  @override
  int get hashCode => title.hashCode ^ icon.hashCode ^ key.hashCode;
}
