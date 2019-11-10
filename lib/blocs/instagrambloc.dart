import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:instagram_clone/models/user.dart';

class InstagramBloc extends ChangeNotifier {
  bool isReady = false;
  bool isLoggedIn = false;
  bool didLoginFail = false;
  bool didLoadFail = false;
  List<Post> timeline = [];
  List<Post> my_posts = [];
  User myAccount;
  String token;

  InstagramBloc() {
    setup();
  }

  Future<void> setup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? null);
    if (token != null) {
      isLoggedIn = true;
      notifyListeners();
      loadData();
    }
  }

  Future<void> loadData() async {
    if (isLoggedIn) {
      bool fetchedTimeline = await fetchTimeline();
      bool fetchedAccount = await fetchAccount();
      if (fetchedTimeline && fetchedAccount) {
        print("is ready");
        isReady = true;
        notifyListeners();
      } else {
        print("is not ready");
        didLoadFail = true;
        notifyListeners();
      }
    } else {
      print("not logged in");
    }
  }

  Future<void> attemptLogin(String username, String password) async {
    print(
        "attempting login https://nameless-escarpment-45560.herokuapp.com/api/login?username=${username}&password=${password}");
    var response = await http.get(
        "https://nameless-escarpment-45560.herokuapp.com/api/login?username=${username}&password=${password}");
    if (response.statusCode == 200) {
      print("succeeded login");
      didLoginFail = false;
      Map<String, dynamic> jsonData = json.decode(response.body);
      token = jsonData["token"];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      if (token != null) {
        isLoggedIn = true;
      }
      notifyListeners();
    } else {
      print(response.body);
      print("login did not succeed");
      didLoginFail = true;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    isLoggedIn = false;
    notifyListeners();
  }

  Future<bool> fetchTimeline() async {
    var response = await http.get(
        "https://nameless-escarpment-45560.herokuapp.com/api/v1/posts",
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    if (response.statusCode == 200) {
      List<dynamic> serverPosts = json.decode(response.body);
      for (int i = 0; i < serverPosts.length; i++) {
        timeline.add(Post.fromJson(serverPosts[i]));
      }
      return true;
    }
    return false;
  }

  Future<bool> fetchAccount() async {
    print("getting account data");
    var response = await http.get(
        "https://nameless-escarpment-45560.herokuapp.com/api/v1/my_account",
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    if (response.statusCode == 200) {
      myAccount = User.fromJson(json.decode(response.body));

      print("getting account posts");
      var my_posts_response = await http.get(
          "https://nameless-escarpment-45560.herokuapp.com/api/v1/my_posts",
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
      if (my_posts_response.statusCode == 200) {
        print("successfully got account posts");
        List<dynamic> server_posts = json.decode(my_posts_response.body);
        my_posts = server_posts.map((p) => Post.fromJson(p)).toList();
        return true;
      }
    } else {
      print(response.body);
      print("account load failed");
    }
    return false;
  }
  
  /*Future<List<String>> fetchComments(int id) async{
    List<String> comments;

    var response = await http.get("https://nameless-escarpment-45560.herokuapp.com/api/v1/posts/$id/comments",
    headers: {HttpHeaders.authorizationHeader: "Bearer $token"});

    if(response.statusCode == 200)
    {
      print(response.body);
      if((comments = json.decode(response.body)) == null)
      {
        return comments = [" ", " "];
      }
      else{
        print(json.decode(response.body));
        return comments = json.decode(response.body);
      }
      ///////////////////////////////////////////
    }
    else{
      print(response.body);
      return null;
    }
    
  }*/
  Future<User> fetchUserAccount(int id) async {
    User u = new User();

    print("getting account data");
    var response = await http.get(
        "https://nameless-escarpment-45560.herokuapp.com/api/v1/users/${id}",
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    if (response.statusCode == 200) {
      u = User.fromJson(json.decode(response.body));

      print("getting account posts");
      var my_posts_response = await http.get(
          "https://nameless-escarpment-45560.herokuapp.com/api/v1/users/${id}/posts",
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
      if (my_posts_response.statusCode == 200) {
        print("successfully got account posts");
        List<dynamic> server_posts = json.decode(my_posts_response.body);
        my_posts = server_posts.map((p) => Post.fromJson(p)).toList();
        return u;
      }
    } else {
      print(response.body);
      print("account load failed");
    }
    return null;
  }

  Future deletePost(int id) async{

  var response = await http.delete(
    'https://nameless-escarpment-45560.herokuapp.com/api/v1/posts/$id',
   headers: {HttpHeaders.authorizationHeader: "Bearer $token"});

   if(response.statusCode == 200)
   {
     print(response.body);
   }
   else{
     print(response.body);
   }

}
  Future toggle(int i, bool decider) async {
    
    if (decider == true) {
      var response = await http.post(
          'https://nameless-escarpment-45560.herokuapp.com/api/v1/posts/${i}/likes',
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
      if (response.statusCode != 201) {
      //  print(response.statusCode);
        my_posts[i].liked= !my_posts[i].liked;
        print(my_posts[i].liked);
        notifyListeners();
        print("it didnt work");
      }
    } else {
      var response = await http.delete(
          'https://nameless-escarpment-45560.herokuapp.com/api/v1/posts/${i}/likes',
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
      if (response.statusCode != 204) {
        print(response.statusCode);
        //my_posts[i].liked= !my_posts[i].liked;
        print("it didnt work");
      }
    }
  }
}

