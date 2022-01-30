import 'dart:convert';

import 'package:student_api_dart/response/user_response.dart';

import 'package:http/http.dart';
import 'package:student_api_dart/models/user.dart';

class HttpConnectUser {
  String baseurl = 'http://10.0.2.2:3000/api/v1';
  String token = '';
  //now sending data to the server

  //User model ko value chai user ma define gareko
  //registering the user
  Future<bool> registerPost(User user) async {
    //post garna ko lagi json body ma MAP banara pathauna aateko
    Map<String, dynamic> userMap = {
      "fname": user.firstname,
      "lname": user.lastname,
      "username": user.username,
      "password": user.password
    };

    final responses =
        await post(Uri.parse(baseurl + '/auth/register'), body: userMap);
    if (responses.statusCode == 200) {
      var userRes = ResponseUser.fromJson(jsonDecode(responses.body));
      return userRes.success!;
    } else {
      return false;
    }
  }

  //sending post req to server for user login
  Future<bool> loginPost(String username, String password) async {
    //lets create a map to send data to server from dart as dart uses map in term of json objects
    Map<String, dynamic> loginUser = {
      'username': username,
      'password': password
    };
    //now lets post data to the sever and store the output in the response variable
    //its same like post login in postman
    try {
      final response =
          await post(Uri.parse(baseurl + 'auth/login'), body: loginUser);

      //now we got the result in response and that is success message and token generated
      //since we are getting repsonse in json form and dart doesn't understand that and lets decode the response body i.e. success and token in map
      //so that we could read the data and can easily proceed further
      final jsonData = jsonDecode(response.body) as Map;

      //now lets take out the token as we already decoded the json data and stored that into the map so called jsonData
      token = jsonData['token'];

      //now lets check the token for furhter login procedure
      if (token.isNotEmpty) {
        return true;
      }
    } catch (e) {
      print(e);
    }

    return false;
  }
}
