import 'package:book_store_trial1/screens/add_book.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../models/book.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          title: Text('Store Page'),
        ),
        body: BooksSlider());
  }
}

class BooksSlider extends StatefulWidget {
  @override
  _BooksSliderState createState() => _BooksSliderState();
}

class _BooksSliderState extends State<BooksSlider> {
  Future<List<Book>> futureBooks;

  Future<List<Book>> getBooks() async {
    List<Book> _mostSearchedBooks = [];
    // var url = 'https://bookstoretrial1.000webhostapp.com/get_books.php';
    var url = 'http://192.168.43.5:80/2ndBookStore/get_books.php';
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      jsonResponse.forEach((bookJSON) {
        Book bookRecord = Book.fromMap(bookJSON);
        _mostSearchedBooks.add(bookRecord);
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return _mostSearchedBooks;
  }

  @override
  void initState() {
    super.initState();
    futureBooks = getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: futureBooks,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                Book book = snapshot.data[index];
                return Column(
                  children: <Widget>[
                    Image.network((book.image != null)
                        ? book.image
                        : 'https://firebasestorage.googleapis.com/v0/b/bookstoretrial1.appspot.com/o/1603871093151?alt=media&token=01ff9e72-a43a-414f-a559-94d1e53a746d'),
                    Text(book.title),
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return Center(child: CircularProgressIndicator());
        },
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
        currentIndex: 0,
        onTap: (index) {
          if (0 == index) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (cotext) => StorePage()));
          } else if (2 == index) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (cotext) => AddBookPage()));
          }
        },
      ),
    );
  }
}
