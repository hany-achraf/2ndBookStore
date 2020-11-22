// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';

// class Book {
//   String title;
//   String condition;
//   //List<String> images = [];
//   String image;
//   num price;
//   bool negotiable = false;
//   DatabaseReference _bookReferenceKey = null;
//   //requests

//   Book(this.title, this.condition, this.price, this.negotiable, this.image);

//   Book.fromJSON(Map<dynamic, dynamic> map) {
//     this.title = map['title'];
//     this.condition = map['condition'];
//     this.price = map['price'];
//     this.negotiable = map['negotiable'];
//     this.image = map['images_urls'];
//   }

//   Map<String, dynamic> toJSON() {
//     return <String, dynamic>{
//       'title': this.title,
//       'condition': this.condition,
//       'price': this.price,
//       'negotiable': this.negotiable,
//       'images_urls': (this.image != null) ? this.image : 'Emplty',
//     };
//   }

//   void setBookReferenceKey(DatabaseReference key) =>
//       this._bookReferenceKey = key;

//   Widget toThumbnail() {
//     return Column(
//       children: <Widget>[
//         /*
//         (this.images.length > 0)
//             ? Image.network(this.images[0])
//             : Icon(Icons.book),
//             */
//         Image.network(this.image, width: 100, height: 100),
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 15,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//         Text(
//           condition,
//           style: TextStyle(
//               fontSize: 10,
//               fontWeight: FontWeight.normal,
//               color: Colors.blueAccent.shade700),
//         ),
//         Center(
//             child: Row(
//           children: <Widget>[
//             Text(
//               '${price}RM',
//               style: TextStyle(
//                 fontSize: 10,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blueAccent,
//               ),
//             ),
//             Text(
//               (negotiable) ? 'Negotiable' : 'Non-Negotiable',
//               style: TextStyle(
//                 fontSize: 10,
//                 fontWeight: FontWeight.bold,
//                 color: (negotiable)
//                     ? Colors.lightGreen.shade600
//                     : Colors.red.shade600,
//               ),
//             ),
//           ],
//         )),
//       ],
//     );
//   }

//   // void addImageUrl(String image_url) {
//   //   this.images.add(image_url);
//   // }
// }
