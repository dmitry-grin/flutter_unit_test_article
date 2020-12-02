import 'dart:convert';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:equatable/equatable.dart';
import 'package:unit_test_article/survey.dart';
import 'package:http/http.dart' as http;

abstract class ReplicantsRepositoryInterface {
  Future<Answer> askedQuestion(GeneralQuestion question);
  num calculate(MathOperator operation, int a, int b);
}

abstract class NetworkInfoInterface {
  Future<bool> get isConnected;
}

abstract class RemoteDataSourceInterface {
  Future<Answer> request(GeneralQuestion question);
}

//Implementations
class NetworkInfo implements NetworkInfoInterface {
  final DataConnectionChecker connectionChecker;
  NetworkInfo({this.connectionChecker});

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}

class RemoteDataSource implements RemoteDataSourceInterface {
  final http.Client client;
  RemoteDataSource({this.client});

  @override
  Future<Answer> request(GeneralQuestion question) async {
    final response =
        await client.get('http://replicantDidAsk${question.toString()}');
    if (response.statusCode == 200) {
      return Answer.fromJson(json.decode(response.body));
    } else {
      throw Exception('${response.statusCode}');
    }
  }
}

class Answer extends Equatable {
  final String text;
  Answer({this.text});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(text: json['text']);
  }

  @override
  List<Object> get props => [text];
}
