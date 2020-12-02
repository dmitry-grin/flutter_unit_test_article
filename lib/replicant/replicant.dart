import 'package:flutter/foundation.dart';
import 'package:unit_test_article/survey.dart';
import 'replicant_interfaces.dart';

class Replicant implements Survey {
  final ReplicantRepository repository;

  Replicant({this.repository});

  @override
  askMathQuestion(MathOperator action, int a, int b) {
    return repository.calculate(action, a, b);
  }

  @override
  Future<Answer> askGeneralQuestion(GeneralQuestion question) async {
    return repository.askedQuestion(question);
  }
}

class ReplicantRepository implements ReplicantsRepositoryInterface {
  final NetworkInfoInterface networkInfo;
  final RemoteDataSourceInterface remoteDataSource;

  ReplicantRepository(
      {@required this.networkInfo, @required this.remoteDataSource});

  final calculator = ComputerMath();

  @override
  Future<Answer> askedQuestion(GeneralQuestion question) async {
    if (await networkInfo.isConnected) {
      return remoteDataSource.request(question);
    }

    return null;
  }

  @override
  num calculate(MathOperator operation, int a, int b) {
    return calculator.compute(operation, a, b);
  }
}
