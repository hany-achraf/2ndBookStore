// import 'dart:io';

// import 'package:book_store_trial1/store.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:multi_image_picker/multi_image_picker.dart';

// import 'book.dart';
// import 'database.dart';

// class MyHomePage extends StatefulWidget {
//   //MyHomePage({Key key}) : super(key: key);

//   final User user;
//   MyHomePage(this.user);

//   @override
//   _MyHomePageState createState() => new _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   //File image = null;
//   List<Asset> _images;

//   double _imageContainerLeftPadding = 130;
//   double _imageContainerWidth = 90;
//   double _imageContainerHeight = 90;

//   final bookTitleCtrl = TextEditingController();
//   final bookConditionCtrl = TextEditingController();
//   final bookPriceCtrl = TextEditingController();
//   var isNegotiable = false;

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       resizeToAvoidBottomPadding: false,
//       appBar: new AppBar(
//         title: new Text('Adding Book'),
//       ),
//       body: Container(
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             mainAxisSize: MainAxisSize.max,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Center(
//                 child: Column(
//                   children: <Widget>[
//                     // Padding(
//                     //   padding: const EdgeInsets.all(8.0),
//                     //   child: Text('Upload Image(s)'),
//                     // ),
//                     Padding(
//                       padding: EdgeInsets.fromLTRB(
//                           _imageContainerLeftPadding, 8, 0, 8),
//                       child: Row(
//                         children: <Widget>[
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.grey.shade300,
//                               border: Border.all(color: Colors.grey),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(5)),
//                             ),
//                             width: _imageContainerWidth,
//                             height: _imageContainerHeight,
//                             child: (null == _images[0])
//                                 ? Icon(Icons.collections,
//                                     color: Colors.grey.shade500, size: 70)
//                                 : Image(
//                                     image: AssetThumbImageProvider(_images[0],
//                                         height: null, width: null),
//                                     fit: BoxFit.fill),
//                           ),
//                           GestureDetector(
//                             child: Icon(Icons.photo_camera),
//                             onTap: () async {
//                               // var image = await ImagePicker.pickImage(
//                               //     source: ImageSource.gallery);
//                               // setState(() {
//                               // _image = image;
//                               // _imageContainerLeftPadding = 105;
//                               // _imageContainerWidth = 150;
//                               // _imageContainerHeight = 150;
//                               // });
//                               List<Asset> images =
//                                   await MultiImagePicker.pickImages(
//                                 maxImages: 4,
//                                 enableCamera: true,
//                               );
//                               setState(() {
//                                 _images = images;
//                                 _imageContainerLeftPadding = 105;
//                                 _imageContainerWidth = 150;
//                                 _imageContainerHeight = 150;
//                               });
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(6.0),
//                 child: TextField(
//                   controller: this.bookTitleCtrl,
//                   style: new TextStyle(
//                       fontSize: 12.0,
//                       color: const Color(0xFF000000),
//                       fontWeight: FontWeight.w200,
//                       fontFamily: "Roboto"),
//                   decoration: InputDecoration(
//                     labelText: 'Book Title',
//                     prefixIcon: Icon(Icons.book),
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         color: Colors.blueGrey,
//                         style: BorderStyle.solid,
//                         width: 3,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(6.0),
//                 child: TextField(
//                   controller: this.bookConditionCtrl,
//                   maxLines: 3,
//                   style: new TextStyle(
//                       fontSize: 12.0,
//                       color: const Color(0xFF000000),
//                       fontWeight: FontWeight.w200,
//                       fontFamily: "Roboto"),
//                   decoration: InputDecoration(
//                     labelText: 'Book Condition',
//                     prefixIcon: Icon(Icons.insert_comment),
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         color: Colors.blueGrey,
//                         style: BorderStyle.solid,
//                         width: 3,
//                       ),
//                     ),
//                   ),
//                   //maxLines: 2,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(6.0),
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.max,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Container(
//                         width: 150,
//                         child: Padding(
//                           padding: const EdgeInsets.all(6.0),
//                           child: TextField(
//                             controller: this.bookPriceCtrl,
//                             maxLength: 6,
//                             maxLengthEnforced: true,
//                             style: TextStyle(
//                                 fontSize: 12.0,
//                                 color: const Color(0xFF000000),
//                                 fontWeight: FontWeight.w200,
//                                 fontFamily: "Roboto"),
//                             decoration: InputDecoration(
//                               labelText: 'Price',
//                               prefixIcon: Icon(Icons.monetization_on),
//                               border: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.blueGrey,
//                                   style: BorderStyle.solid,
//                                   width: 3,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(60, 0, 0, 12),
//                         child: new Text(
//                           "Negotiable",
//                           style: new TextStyle(
//                               fontSize: 16.0,
//                               color: const Color(0xFF000000),
//                               fontWeight: FontWeight.w200,
//                               fontFamily: "Roboto"),
//                         ),
//                       ),
//                       Padding(
//                           padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
//                           child: Switch(
//                             value: this.isNegotiable,
//                             onChanged: (bool newValue) {
//                               setState(() {
//                                 this.isNegotiable = newValue;
//                               });
//                             },
//                           ))
//                     ]),
//               ),
//             ]),
//         alignment: Alignment.center,
//       ),
//       bottomNavigationBar: new BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         items: [
//           BottomNavigationBarItem(
//             icon: const Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: const Icon(Icons.search),
//             label: 'Search',
//           ),
//           BottomNavigationBarItem(
//             icon: const Icon(Icons.arrow_upward),
//             label: 'Add',
//           ),
//         ],
//         currentIndex: 2,
//         onTap: (index) {
//           if (0 == index) {
//             Navigator.of(context)
//                 .push(MaterialPageRoute(builder: (cotext) => StorePage()));
//           }
//         },
//       ),
//       floatingActionButton: Center(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 600, left: 30),
//           child: FloatingActionButton(
//             onPressed: () async {
//               final Book newBook = new Book(
//                   this.bookTitleCtrl.text,
//                   this.bookConditionCtrl.text,
//                   double.parse(this.bookPriceCtrl.text),
//                   this.isNegotiable);
//               final DatabaseReference newBookKey = ref.child('books/').push();
//               newBook.setBookReferenceKey(newBookKey);
//               await ref
//                   .child('books/' + widget.user.uid + newBookKey.key)
//                   .update(newBook.toJSON());
//               setState(() {
//                 this.bookConditionCtrl.clear();
//                 this.bookPriceCtrl.clear();
//                 this.bookTitleCtrl.clear();
//                 this.isNegotiable = false;
//               });
//             },
//             child: Icon(Icons.done),
//             backgroundColor: Colors.green.shade300,
//           ),
//         ),
//       ),
//     );
//   }
// }
