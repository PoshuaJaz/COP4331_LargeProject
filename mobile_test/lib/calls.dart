import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile_test/models.dart';

String uri = "http://www.dirediredocks.xyz/api/";

Future<ResetPassword> resetPassword(String email, String password) async {
  final response = await http.post(
    Uri.parse('${uri}auth/resetPassword'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'email': email, 'password': password}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return ResetPassword.fromJson(jsonDecode(response.body));
  } else if (response.statusCode >= 400 && response.statusCode < 500) {
    return ResetPassword.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

Future<Login> createLogin(String username, String password) async {
  final response = await http.post(
    Uri.parse('${uri}auth/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Login.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    final resBody = jsonDecode(response.body);
    throw Exception(resBody['message'] ?? 'Login failed');
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
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to fetch album');
  }
}

// returns list of problems of topic
Future<List<Problem>> fetchProblems(String topic) async {
  final response = await http.get(Uri.parse("${uri}test/topic/$topic"));

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
  final response = await http.get(Uri.parse("${uri}test/mocktest"));

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
  CurrentUser currUser = CurrentUser();
  var token = currUser.token;

  final response = await http.post(
    Uri.parse("${uri}test/submit"),
    body: jsonEncode(Answer.toJson(answer)),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer $token",
    },
  );

  if (response.statusCode != 201) {
    throw Exception("Failed: ${response.statusCode} - ${response.body}");
  }
}

Future<Progress> getProgress(String token) async {
  final response = await http.get(
    Uri.parse('${uri}progress/graph'),
    headers: <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Progress.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    final resBody = jsonDecode(response.body);
    throw Exception(resBody['message'] ?? 'getProgress failed');
  }
}

// Sends new user data to server
Future<http.Response> postData({
  required String firstName,
  required String lastName,
  required String userName,
  required String password,
  required String email,
}) async {
  try {
    var response = await http.post(
      Uri.parse("${uri}auth/signup"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "username": userName,
        "password": password,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
      }),
    );
    return response;
  } catch (e) {
    throw Exception("Error: $e");
  }
}

// get massage
Future<Map<String, dynamic>> getMessageData(String token) async {
  final response = await http.get(
    Uri.parse('${uri}progress/messageData'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    final resBody = jsonDecode(response.body);
    throw Exception(resBody['message'] ?? 'getMessageData failed');
  }
}

// get the problem solved today
// progress/history only saves 10 questions in total on 1 page
// need to search the page to find out the total number of questions solved today.
Future<int> getHistory(String token) async {
  int page = 1;
  int todayCount = 0;
  bool data = true;

  DateTime now = DateTime.now();

  while (data) {
    final response = await http.get(
      Uri.parse('${uri}progress/history?page=$page'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      var decoded = jsonDecode(response.body);
      List<dynamic> historyJson = decoded["history"];
      List<History> historyList =
          historyJson.map((e) => History.fromJson(e)).toList();

      todayCount +=
          historyList.where((h) {
            DateTime dt = DateTime.parse(h.datetime).toLocal();
            return dt.year == now.year &&
                dt.month == now.month &&
                dt.day == now.day;
          }).length;

      int totalPages = decoded["totalPages"];
      page++;
      data = page <= totalPages;
    } else {
      throw Exception("Failed to load answer history.");
    }
  }

  return todayCount;
}
