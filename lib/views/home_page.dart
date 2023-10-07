import 'package:blog_explorer/adapter/post_adapter.dart';
import 'package:blog_explorer/controller/controller.dart';
import 'package:blog_explorer/models/post.dart';
import 'package:blog_explorer/services/remote_services.dart';
//import 'package:blog_explorer/views/detailed_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Post?>? postsFuture;
  final PostController postController = Get.find();
  @override
  void initState() {
    super.initState();
    postsFuture = RemoteService().getPosts(); //blogs are fetched
    Hive.initFlutter();
    Hive.registerAdapter(PostAdapter());
  }

  Future<List<Blog>> fetchDataFromAPI() async {
    final apiUrl = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final List<Blog> blogs =
          jsonData.map((data) => Blog.fromJson(data)).toList();
      return blogs;
    } else {
      throw Exception('We are unable to load blogs.');
    }
  }

  //data is stored
  Future<void> openAndStoreData() async {
    final box = await Hive.openBox<Blog>('blogs');
    box.clear();
    final fetchedData = await fetchDataFromAPI();
    box.addAll(fetchedData);
  }

//if hive storage is empty
  Future<List<Blog>> getBlogs() async {
    final box = await Hive.openBox<Blog>('blogs');
    if (box.isEmpty) {
      final fetchedData = await fetchDataFromAPI();
      box.addAll(fetchedData);
    }

    return box.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title:  Text('Blog Explorer', style: GoogleFonts.raleway(
          fontSize: 20,
          fontWeight: FontWeight.w500
         ),),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<Post?>(
        future: postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading data'),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text('We are sorry, Blogs are not available'),
            );
          } else {
            final post = snapshot.data!;
            return ListView.builder(
              itemCount: post.blogs.length,
              itemBuilder: (context, index) {
                //final isFavorite = postController.isFavorite(post.blogs[index]);
                final blog = post.blogs[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/blogDetail',
                      arguments: {
                        'imageUrl': post.blogs[index].imageUrl,
                        'title': post.blogs[index].title,
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.black),
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        child: Image.network(
                          post.blogs[index].imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    
                      title: Text(
      post.blogs[index].title,
      style: GoogleFonts.oswald(
        fontSize: 16, 
        fontWeight: FontWeight.bold, 
      ),
    ),
                      trailing: GestureDetector(
                        onTap: () {
                          postController.makemyfavorite(blog);
                        },
                        child: IconButton(
                          icon: Obx(() {
                            final isFavorite = blog.isFavorite.value;
                            return Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.black,
                            );
                          }),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
