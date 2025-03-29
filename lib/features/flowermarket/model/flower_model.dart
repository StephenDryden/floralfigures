import 'package:uuid/uuid.dart';

class Flower {
  final String id;
  final String name;
  final double pricePerStem;
  final int stemsPerBundle;

  Flower({
    String? id,
    required this.name,
    required this.pricePerStem,
    required this.stemsPerBundle,
  }) : id = id ?? const Uuid().v4();
}
