import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Book {
  String title;
  String book_condition;
  List<String> images = [];
  String image;
  num price;
  bool negotiable = false;
  String owner_id;
  int num_of_reqs;

  Book(this.title, this.book_condition, this.price, this.negotiable,
      this.owner_id);

  Book.fromMap(Map<dynamic, dynamic> map) {
    this.title = map['title'];
    this.price = double.parse(map['price']);
    this.negotiable = (map['negotiable'] == "1") ? true : false;
    this.image = map['thumbnail_image'];
    this.num_of_reqs = int.parse(map['num_of_likes']);
  }

  Map<String, dynamic> toJSON() {
    return <String, dynamic>{
      'title': this.title,
      'book_condition': this.book_condition,
      'price': this.price,
      'negotiable': (this.negotiable) ? 1 : 0,
      'images_urls': this.images,
      'owner_id': this.owner_id,
    };
  }

  // Widget toThumbnail() {
  //   return Column(
  //     children: <Widget>[
  //       Image.network(this.image, width: 100, height: 100),
  //       Text(
  //         title,
  //         style: TextStyle(
  //           fontSize: 15,
  //           fontWeight: FontWeight.bold,
  //           color: Colors.black,
  //         ),
  //       ),
  //       Center(
  //           child: Row(
  //         children: <Widget>[
  //           Text(
  //             '${price}RM',
  //             style: TextStyle(
  //               fontSize: 10,
  //               fontWeight: FontWeight.bold,
  //               color: Colors.blueAccent,
  //             ),
  //           ),
  //           Text(
  //             (negotiable) ? 'Negotiable' : 'Non-Negotiable',
  //             style: TextStyle(
  //               fontSize: 10,
  //               fontWeight: FontWeight.bold,
  //               color: (negotiable)
  //                   ? Colors.lightGreen.shade600
  //                   : Colors.red.shade600,
  //             ),
  //           ),
  //         ],
  //       )),
  //     ],
  //   );
  // }

  void addImageUrl(String image_url) {
    this.images.add(image_url);
  }
}
