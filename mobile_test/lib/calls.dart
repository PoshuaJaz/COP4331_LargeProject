import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_test/models.dart';

String uri = "http://www.dirediredocks.xyz/api/";

Future<Login> createLogin(String username, String password) async {
  final response = await http.post(
    Uri.parse('${uri}auth/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'username': username, 'password': password}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Login.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

Future<Verify> verifyEmail(String email, String otp) async {
  final response = await http.post(
    Uri.parse('${uri}auth/verify'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'email': email, 'otp': otp}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Verify.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

Future<SendOtp> sendEmailCode(String email, String reason) async {
  final response = await http.post(
    Uri.parse('${uri}auth/sendotp'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'email': email, 'purpose': reason}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return SendOtp.fromJson(jsonDecode(response.body));
  } else if (response.statusCode >= 400 && response.statusCode < 500) {
    return SendOtp.fromJson(jsonDecode(response.body));
  }else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to fetch album');
  }
}

// returns list of problems of topic
Future<List<Problem>> fetchProblems(String topic) async {
  final response = await http.get(
    Uri.parse("${uri}test/topic/$topic")
  );

  if (response.statusCode == 200) {
    // decode the json response
    var p = jsonDecode(response.body);
    // build a list of problem objects
    var problems = List<Problem>.empty(growable: true);
    for (int i = 0; i < p.length; i++) {
      // throw each problem json into the factory to add to the problemlist
      problems.add(Problem.fromJson(p[i]));
    }
    return problems;
  } else {
    throw Exception('Failed to load problems!');
  }
}

// returns list of mocktest problems
Future<List<Problem>> fetchMockTest() async {
  final response = await http.get(
    Uri.parse("${uri}test/mocktest")
  );

  if (response.statusCode == 200) {
    // decode the json response
    var p = jsonDecode(response.body)["problems"];
    // build a list of problem objects
    var problems = List<Problem>.empty(growable: true);
    for (int i = 0; i < p.length; i++) {
      // throw each problem json into the factory to add to the problemlist
      problems.add(Problem.fromJson(p[i]));
    }
    return problems;
  } else {
    throw Exception('Failed to load problems!');
  }
}

// submits an answer object to the database
void postAnswer(Answer answer) async {
  var token = ""; //TODO
  final response = await http.post(
    Uri.parse("${uri}test/submit"),
    body: jsonEncode(Answer.toJson(answer)),
    headers: {
      "Authorization": "Bearer ${token}",
    }
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to submit answer!');
  }
}