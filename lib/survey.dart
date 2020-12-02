import 'package:unit_test_article/replicant/replicant_interfaces.dart';

abstract class Survey {
  Future<Answer> askGeneralQuestion(GeneralQuestion question);
  askMathQuestion(MathOperator o, int a, int b);
}

enum GeneralQuestion {
  PHYSICS,
  HISTORY,
  BIOLOGY,
  CHEMISTRY,
  ASTRONOMY,
  GEOGRAPHY,
  THEOLOGY
}

enum MathOperator { ADDITION, SUBTRACTION, DIVISION, MULTIPLY }

class Math {
  num addition(int a, int b) => a + b;
  num subtraction(int a, int b) => a - b;
  num division(int a, int b) => a / b;
  num multiply(int a, int b) => a * b;

  compute(MathOperator o, int a, int b) {
    throw UnimplementedError('needs to be overriden in ancestors');
  }
}

class SimpleMath extends Math {
  @override
  Future<num> compute(MathOperator o, int a, int b) async {
    num result;

    switch (o) {
      case MathOperator.ADDITION:
        result = addition(a, b);
        break;
      case MathOperator.SUBTRACTION:
        result = subtraction(a, b);
        break;
      case MathOperator.DIVISION:
        result = division(a, b);
        break;
      case MathOperator.MULTIPLY:
        result = multiply(a, b);
        break;
    }

    return Future.value(result);
  }
}

class ComputerMath extends Math {
  @override
  compute(MathOperator o, int a, int b) {
    switch (o) {
      case MathOperator.ADDITION:
        return addition(a, b);
      case MathOperator.SUBTRACTION:
        return subtraction(a, b);
      case MathOperator.DIVISION:
        return division(a, b);
      case MathOperator.MULTIPLY:
        return multiply(a, b);
    }
  }
}
