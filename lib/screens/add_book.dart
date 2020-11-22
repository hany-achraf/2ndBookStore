import 'dart:async';

import 'package:book_store_trial1/screens/store.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import '../models/book.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AddBookPage extends StatefulWidget {
  //AddBookPage({Key key}) : super(key: key);
  // final User user;
  // AddBookPage(this.user);
  AddBookPage();

  @override
  _AddBookPageState createState() => new _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  List<Asset> _images = [];
  StreamController<String> _imagesUrlsController;

  double _imageContainerLeftPadding = 130;
  double _imageContainerWidth = 90;
  double _imageContainerHeight = 90;

  final bookTitleCtrl = TextEditingController();
  final bookConditionCtrl = TextEditingController();
  final bookPriceCtrl = TextEditingController();
  var isNegotiable = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        title: new Text('Adding Book'),
      ),
      body: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          _imageContainerLeftPadding, 8, 0, 8),
                      child: Row(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              border: Border.all(color: Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            width: _imageContainerWidth,
                            height: _imageContainerHeight,
                            child: (_images.isEmpty)
                                ? Icon(Icons.collections,
                                    color: Colors.grey.shade500, size: 70)
                                : Image(
                                    image: AssetThumbImageProvider(_images[0],
                                        height: 350,
                                        width: 350,
                                        quality: 100,
                                        scale: 1.0),
                                    fit: BoxFit.fill),
                          ),
                          GestureDetector(
                            child: Icon(Icons.photo_camera),
                            onTap: () async {
                              List<Asset> images =
                                  await MultiImagePicker.pickImages(
                                maxImages: 4,
                                enableCamera: true,
                              );

                              //postImage(images[0]);

                              setState(() {
                                _images = images;
                                _imageContainerLeftPadding = 105;
                                _imageContainerWidth = 150;
                                _imageContainerHeight = 150;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextField(
                  controller: this.bookTitleCtrl,
                  style: new TextStyle(
                      fontSize: 12.0,
                      color: const Color(0xFF000000),
                      fontWeight: FontWeight.w200,
                      fontFamily: "Roboto"),
                  decoration: InputDecoration(
                    labelText: 'Book Title',
                    prefixIcon: Icon(Icons.book),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                        style: BorderStyle.solid,
                        width: 3,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextField(
                  controller: this.bookConditionCtrl,
                  maxLines: 3,
                  style: new TextStyle(
                      fontSize: 12.0,
                      color: const Color(0xFF000000),
                      fontWeight: FontWeight.w200,
                      fontFamily: "Roboto"),
                  decoration: InputDecoration(
                    labelText: 'Book Condition',
                    prefixIcon: Icon(Icons.insert_comment),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                        style: BorderStyle.solid,
                        width: 3,
                      ),
                    ),
                  ),
                  //maxLines: 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: TextField(
                            controller: this.bookPriceCtrl,
                            maxLength: 6,
                            maxLengthEnforced: true,
                            style: TextStyle(
                                fontSize: 12.0,
                                color: const Color(0xFF000000),
                                fontWeight: FontWeight.w200,
                                fontFamily: "Roboto"),
                            decoration: InputDecoration(
                              labelText: 'Price',
                              prefixIcon: Icon(Icons.monetization_on),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blueGrey,
                                  style: BorderStyle.solid,
                                  width: 3,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(60, 0, 0, 12),
                        child: new Text(
                          "Negotiable",
                          style: new TextStyle(
                              fontSize: 16.0,
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.w200,
                              fontFamily: "Roboto"),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                          child: Switch(
                            value: this.isNegotiable,
                            onChanged: (bool newValue) {
                              setState(() {
                                this.isNegotiable = newValue;
                              });
                            },
                          ))
                    ]),
              ),
            ]),
        alignment: Alignment.center,
      ),
      bottomNavigationBar: new BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.arrow_upward),
            title: Text('Add'),
          ),
        ],
        currentIndex: 2,
        onTap: (index) {
          if (0 == index) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (cotext) => StorePage()));
          }
        },
      ),
      floatingActionButton: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 600, left: 30),
          child: FloatingActionButton(
            onPressed: () {
              final Book newBook = new Book(
                  this.bookTitleCtrl.text,
                  this.bookConditionCtrl.text,
                  double.parse(this.bookPriceCtrl.text),
                  this.isNegotiable,
                  /*widget.user.uid*/ 'QM4wnDOyO7PSHE5ua1HlfPK66EK2');

              Stream<String> stream = postImages(_images);
              stream.listen((image_url) {
                newBook.addImageUrl(image_url);
              }, onDone: () async {
                final http.Response response = await http.post(
                    // 'https://bookstoretrial1.000webhostapp.com/upload_book.php',
                    'http://192.168.43.5:80/2ndBookStore/upload_book.php',
                    body: <String, dynamic>{
                      "BookJSON": "'${jsonEncode(newBook.toJSON())}'",
                    });
                if (200 == response.statusCode) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (cotext) => StorePage()));
                } else {}
              });
            },
            child: Icon(Icons.done),
            backgroundColor: Colors.green.shade300,
          ),
        ),
      ),
    );
  }
}

final FirebaseStorage storage =
    FirebaseStorage(storageBucket: 'gs://bookstoretrial1.appspot.com');

Stream<String> postImages(List<Asset> imagesFiles) async* {
  for (var imageFile in imagesFiles) {
    var imageData = await imageFile.getByteData();
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = storage.ref().child(fileName);
    StorageUploadTask uploadTask =
        reference.putData(imageData.buffer.asUint8List());
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    String image_url = await storageTaskSnapshot.ref.getDownloadURL();
    yield image_url;
  }
}
