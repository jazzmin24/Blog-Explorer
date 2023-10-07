//model
import 'dart:convert';
import 'package:get/get.dart';


Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
    List<Blog> blogs;

    Post({
        required this.blogs,
    });

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        blogs: List<Blog>.from(json["blogs"].map((x) => Blog.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "blogs": List<dynamic>.from(blogs.map((x) => x.toJson())),
    };
}

class Blog {
    String id;
    String imageUrl;
    String title;
    final RxBool isFavorite;

    Blog({
        required this.id,
        required this.imageUrl,
        required this.title,
         bool isFavorite = false,
    }): isFavorite = isFavorite.obs;

  // Factory method for creating a Blog object with a default value for isFavorite

    factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        id: json["id"],
        imageUrl: json["image_url"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": imageUrl,
        "title": title,
    };
}