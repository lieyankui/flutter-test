import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
// Welcome to Flutter
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final wordPair = WordPair.random();
//     return MaterialApp(
//       title: 'Welcome to Flutter.',
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Welcome to Flutter'),
//         ),
//         body: Center(
//           child: Text(wordPair.asPascalCase),
//         ),
//       ),
//     );
//   }
// }
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blueAccent,
      )),
      home: const RandomWords(),
    );
  }
}



void main() => runApp(const MyApp());

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = <WordPair>{};
  @override
  Widget build(BuildContext context) {
    // final wordPair = new WordPair.random();
    // return (new Text(wordPair.asPascalCase));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Startupa Name Generator'),
        actions: [
          IconButton(onPressed: _pushSaved, icon: const Icon(Icons.list), tooltip: 'Saved Suggestions',),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        final tiles = _saved.map((pair) {
          return ListTile(
            title: Text(
              pair.asPascalCase,
              style: _biggerFont,
            ),
          );
        });
        final divided = tiles.isNotEmpty?
            ListTile.divideTiles(tiles: tiles, context: context).toList() : <Widget>[];

        return Scaffold(
          appBar: AppBar(
            title: const Text('Save Suggestions'),
          ),
          body: ListView(
            children: divided,
          ),
        );
      }),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}



