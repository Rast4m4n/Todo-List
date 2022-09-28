import 'package:flutter/material.dart';

enum PriorityEnum {
  low(1),
  medium(2),
  high(3);

  final int value;
  const PriorityEnum(this.value);
}

extension PriorityEnumExt on PriorityEnum {
  static PriorityEnum getById(int id) {
    if (id == 1) {
      return PriorityEnum.low;
    } else if (id == 2) {
      return PriorityEnum.medium;
    } else if (id == 3) {
      return PriorityEnum.high;
    }
    return PriorityEnum.low;
  }

  Color getColor() {
    switch (this) {
      case PriorityEnum.low:
        return Colors.grey;
      case PriorityEnum.medium:
        return Colors.green;
      case PriorityEnum.high:
        return Colors.red;
    }
  }

  String getName() {
    switch (this) {
      case PriorityEnum.low:
        return 'Низкий приоритет';
      case PriorityEnum.medium:
        return 'Средний приоритет';
      case PriorityEnum.high:
        return 'Высокий приоритет';
    }
  }
}

// void tedt() {
  // final priortiy = PriorityEnum.medium;
  // priortiy.getColor();
  // priortiy.getName();
  // PriorityEnum.values
  //     .map((e) => Row(Icon(color: e.getColor()), Text(e.getName())));
  // priortiy.value;
  // PriorityEnumExt.getById(3);
// }
