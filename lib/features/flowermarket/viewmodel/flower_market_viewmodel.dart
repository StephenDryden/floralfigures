import 'package:flutter/material.dart';
import '../model/flower_model.dart';

class FlowerMarketViewModel extends ChangeNotifier {
  final List<Flower> _flowerList = [];

  List<Flower> get flowerList => _flowerList;

  bool addFlower(Flower flower) {
    if (_flowerExists(flower.name)) {
      return false;
    }
    _flowerList.add(flower);
    notifyListeners();
    return true;
  }

  bool editFlower(Flower updatedFlower) {
    final index = _flowerList.indexWhere((f) => f.id == updatedFlower.id);
    if (index == -1 ||
        _flowerExists(updatedFlower.name, excludeId: updatedFlower.id)) {
      return false;
    }
    _flowerList[index] = updatedFlower;
    notifyListeners();
    return true;
  }

  void deleteFlower(String id) {
    _flowerList.removeWhere((f) => f.id == id);
    notifyListeners();
  }

  bool _flowerExists(String name, {String? excludeId}) {
    return _flowerList
        .any((f) => f.name == name && (excludeId == null || f.id != excludeId));
  }
}
