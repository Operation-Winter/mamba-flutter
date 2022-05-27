// ignore_for_file: constant_identifier_names

enum PlanningCard {
  ZERO,
  ONE,
  TWO,
  THREE,
  FIVE,
  EIGHT,
  THIRTEEN,
  TWENTY,
  FOURTY,
  HUNDRED,
  QUESTION,
}

extension PlanningCardExtension on PlanningCard {
  String get title {
    switch (this) {
      case PlanningCard.ZERO:
        return '0';
      case PlanningCard.ONE:
        return '1';
      case PlanningCard.TWO:
        return '2';
      case PlanningCard.THREE:
        return '3';
      case PlanningCard.FIVE:
        return '5';
      case PlanningCard.EIGHT:
        return '8';
      case PlanningCard.THIRTEEN:
        return '13';
      case PlanningCard.TWENTY:
        return '20';
      case PlanningCard.FOURTY:
        return '40';
      case PlanningCard.HUNDRED:
        return '100';
      case PlanningCard.QUESTION:
        return '?';
    }
  }

  int get sortOrder {
    switch (this) {
      case PlanningCard.ZERO:
        return 0;
      case PlanningCard.ONE:
        return 1;
      case PlanningCard.TWO:
        return 2;
      case PlanningCard.THREE:
        return 3;
      case PlanningCard.FIVE:
        return 4;
      case PlanningCard.EIGHT:
        return 5;
      case PlanningCard.THIRTEEN:
        return 6;
      case PlanningCard.TWENTY:
        return 7;
      case PlanningCard.FOURTY:
        return 8;
      case PlanningCard.HUNDRED:
        return 9;
      case PlanningCard.QUESTION:
        return 10;
    }
  }
}
