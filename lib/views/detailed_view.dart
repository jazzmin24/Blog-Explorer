import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Detailedview extends StatelessWidget {
// const Detailedview({required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final imageUrl = arguments['imageUrl'];
    final title = arguments['title'];
    return Scaffold(
      backgroundColor: Colors.grey,
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   title: Text(
      //     title,
      //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      //   ),
      // ),
      body: Center(
        
              child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0), // Add a border radius
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20), // Add spacing
            Container(
              padding: EdgeInsets.all(9),

             alignment: Alignment.center,
              child: Text(  
                title,
                style: GoogleFonts.robotoSerif(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
          ],
        ), 
      ),
    );
  }
}
