
import 'package:blog_explorer/models/post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class RemoteService {
  Future<Post?> getPosts() async {
    var client = http.Client(); // http client instance
    var uri = Uri.parse('https://intent-kit-16.hasura.app/api/rest/blogs');
    
    var headers = <String, String>{
      'x-hasura-admin-secret': '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6',
      // Add other headers as needed
    };
    
    var response = await client.get(uri, headers: headers);
    
    if (response.statusCode == 200) {
      var json = response.body;
      // Parse the JSON response into a Post object
     return Post.fromJson(jsonDecode(json));
    }
    
    return null;
  }
}