import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yonsei_financial_tech/components/components.dart';

class PaperPage extends StatefulWidget {
  @override
  _PaperPageState createState() => _PaperPageState();
}

class _PaperPageState extends State<PaperPage> {
  ScrollController _controller = new ScrollController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference papers = FirebaseFirestore.instance.collection('paper');

  var fetchedData;

  // filter
  var filterText = '';

  @override
  void initState() {
    super.initState();
    fetchedData = papers.orderBy('number').get();
  }

  // search action
  void searchWithTitle(String title) {
    setState(() {
      filterText = title;
    });
  }

  // FOR TESTING
//   Future<void> add() {
//     for (int i = 1; i < 3; ++i) {
//       FirebaseFirestore.instance.collection('publication')
//       .add({
//         'number': i,
//         'title': 'test-' + i.toString(),
//         'writer': 'test-writer',
//         'date': '21.04.12',
//         'view': Random().nextInt(50),
//         'content': '''
//         ---
// __Advertisement :)__

// - __[pica](https://nodeca.github.io/pica/demo/)__ - high quality and fast image
//   resize in browser.
// - __[babelfish](https://github.com/nodeca/babelfish/)__ - developer friendly
//   i18n with plurals support and easy syntax.

// You will like those projects!

// ---

// # h1 Heading 8-)
// ## h2 Heading
// ### h3 Heading
// #### h4 Heading
// ##### h5 Heading
// ###### h6 Heading


// ## Horizontal Rules

// ___

// ---

// ***


// ## Typographic replacements

// Enable typographer option to see result.

// (c) (C) (r) (R) (tm) (TM) (p) (P) +-

// test.. test... test..... test?..... test!....

// !!!!!! ???? ,,  -- ---

// "Smartypants, double quotes" and 'single quotes'


// ## Emphasis

// **This is bold text**

// __This is bold text__

// *This is italic text*

// _This is italic text_

// ~~Strikethrough~~


// ## Blockquotes


// > Blockquotes can also be nested...
// >> ...by using additional greater-than signs right next to each other...
// > > > ...or with spaces between arrows.


// ## Lists

// Unordered

// + Create a list by starting a line with `+`, `-`, or `*`
// + Sub-lists are made by indenting 2 spaces:
//   - Marker character change forces new list start:
//     * Ac tristique libero volutpat at
//     + Facilisis in pretium nisl aliquet
//     - Nulla volutpat aliquam velit
// + Very easy!

// Ordered

// 1. Lorem ipsum dolor sit amet
// 2. Consectetur adipiscing elit
// 3. Integer molestie lorem at massa


// 1. You can use sequential numbers...
// 1. ...or keep all the numbers as `1.`

// Start numbering with offset:

// 57. foo
// 1. bar


// ## Code

// Inline `code`

// Indented code

//     // Some comments
//     line 1 of code
//     line 2 of code
//     line 3 of code


// Block code "fences"

// ```
// Sample text here...
// ```

// Syntax highlighting

// ``` js
// var foo = function (bar) {
//   return bar++;
// };

// console.log(foo(5));
// ```

// ## Tables

// | Option | Description |
// | ------ | ----------- |
// | data   | path to data files to supply the data that will be passed into templates. |
// | engine | engine to be used for processing templates. Handlebars is the default. |
// | ext    | extension to be used for dest files. |

// Right aligned columns

// | Option | Description |
// | ------:| -----------:|
// | data   | path to data files to supply the data that will be passed into templates. |
// | engine | engine to be used for processing templates. Handlebars is the default. |
// | ext    | extension to be used for dest files. |


// ## Links

// [link text](http://dev.nodeca.com)

// [link with title](http://nodeca.github.io/pica/demo/ "title text!")

// Autoconverted link https://github.com/nodeca/pica (enable linkify to see)


// ## Images

// ![Minion](https://octodex.github.com/images/minion.png)
// ![Stormtroopocat](https://octodex.github.com/images/stormtroopocat.jpg "The Stormtroopocat")

// Like links, Images also have a footnote style syntax

// ![Alt text][id]

// With a reference later in the document defining the URL location:

// [id]: https://octodex.github.com/images/dojocat.jpg  "The Dojocat"


// ## Plugins

// The killer feature of `markdown-it` is very effective support of
// [syntax plugins](https://www.npmjs.org/browse/keyword/markdown-it-plugin).


// ### [Emojies](https://github.com/markdown-it/markdown-it-emoji)

// > Classic markup: :wink: :crush: :cry: :tear: :laughing: :yum:
// >
// > Shortcuts (emoticons): :-) :-( 8-) ;)

// see [how to change output](https://github.com/markdown-it/markdown-it-emoji#change-output) with twemoji.


// ### [Subscript](https://github.com/markdown-it/markdown-it-sub) / [Superscript](https://github.com/markdown-it/markdown-it-sup)

// - 19^th^
// - H~2~O


// ### [\<ins>](https://github.com/markdown-it/markdown-it-ins)

// ++Inserted text++


// ### [\<mark>](https://github.com/markdown-it/markdown-it-mark)

// ==Marked text==


// ### [Footnotes](https://github.com/markdown-it/markdown-it-footnote)

// Footnote 1 link[^first].

// Footnote 2 link[^second].

// Inline footnote^[Text of inline footnote] definition.

// Duplicated footnote reference[^second].

// [^first]: Footnote **can have markup**

//     and multiple paragraphs.

// [^second]: Footnote text.


// ### [Definition lists](https://github.com/markdown-it/markdown-it-deflist)

// Term 1

// :   Definition 1
// with lazy continuation.

// Term 2 with *inline markup*

// :   Definition 2

//         { some code, part of Definition 2 }

//     Third paragraph of definition 2.

// _Compact style:_

// Term 1
//   ~ Definition 1

// Term 2
//   ~ Definition 2a
//   ~ Definition 2b


// ### [Abbreviations](https://github.com/markdown-it/markdown-it-abbr)

// This is HTML abbreviation example.

// It converts "HTML", but keep intact partial entries like "xxxHTMLyyy" and so on.

// *[HTML]: Hyper Text Markup Language

// ### [Custom containers](https://github.com/markdown-it/markdown-it-container)

// ::: warning
// *here be dragons*
// :::

//         '''
//       }).then((value) => print('completed'));
//     }
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
              controller: _controller,
              child: FutureBuilder<QuerySnapshot>(
                future: fetchedData,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('500 - error'));
                  } else if (!snapshot.hasData) {
                    return Column(
                      children: <Widget>[
                        // MENU BAR ----------------------------------------------------------
                        MenuBar(),
                        Container(
                          color: Colors.white,
                          width: double.infinity,
                          height: 400,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        Footer()
                      ],
                    );
                  } else {
                    // data
                    List<Map<String, dynamic>> data = [];
                    // add filtering
                    snapshot.data.docs.forEach((element) {
                      if (filterText.length == 0) {
                        data.add(element.data());
                      } else {
                        if (element
                            .data()['title']
                            .toString()
                            .contains(filterText)) {
                          data.add(element.data());
                        }
                      }
                    });
                    // reverse data
                    data = data.reversed.toList();
                    print(data.length);
                    return Column(
                      children: <Widget>[
                        // MENU BAR ----------------------------------------------------------
                        MenuBar(),
                        // TextButton(
                        //   onPressed: add,
                        //   child: Text("ADD!!!"),
                        // ),
                        // IMAGE BACKGROUND - NAME -------------------------------------------
                        searchTab(context),
                        filterText.length != 0
                            ? Align(
                                alignment: Alignment.topRight,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                          vertical: 20),
                                      color: themeBlue.withOpacity(0.7),
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            "'" +
                                                filterText +
                                                "'" +
                                                ' 관련 검색 결과 초기화',
                                            style: h3WhiteTextStyle,
                                          ),
                                          TextButton.icon(
                                              onPressed: () {
                                                setState(() {
                                                  filterText = '';
                                                });
                                              },
                                              icon: Icon(Icons.close_rounded,
                                                  color: Colors.white,
                                                  size: 22),
                                              label: Text('')),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(),
                        // Board  ------------------------------------------------------------
                        BoardArticle(board: data),
                        Footer(),
                      ],
                    );
                  }
                },
              )),
        ],
      ),
    );
  }

  Widget searchTab(BuildContext context) {
    var md = MediaQuery.of(context).size;

    TextEditingController textEditingController = new TextEditingController();

    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Container(
            // height: md.height * 0.58,
            height: 400,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('images/workingpaper.jpg'),
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.darken),
              fit: BoxFit.cover,
            ))),
        Container(
          margin: marginHorizontal(md.width * 0.5),
          height: md.width > 600 ? 60 : 120,
          child: md.width > 600
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                        flex: 7,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset.fromDirection(-2.0),
                                  blurRadius: 16.0,
                                )
                              ],
                              borderRadius: BorderRadius.circular(20.0)),
                          child: TextFormField(
                              controller: textEditingController,
                              onChanged: (value) {
                                textEditingController.text = value;
                                // setting cursor position
                                textEditingController.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset:
                                            textEditingController.text.length));
                              },
                              cursorColor: Colors.blue[400],
                              cursorWidth: 4.0,
                              cursorHeight: 20,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '검색할 제목을 입력해주세요.',
                                  labelStyle: GoogleFonts.nanumGothicCoding(
                                      color: Colors.black87,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.0))),
                        )),
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: () =>
                              searchWithTitle(textEditingController.text),
                          style: ElevatedButton.styleFrom(
                              primary: themeBlue,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              )),
                          child: Text("검색",
                              style: GoogleFonts.nanumGothicCoding(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0)),
                        ))
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                        flex: 5,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset.fromDirection(-2.0),
                                  blurRadius: 16.0,
                                )
                              ],
                              borderRadius: BorderRadius.circular(20.0)),
                          child: TextFormField(
                              controller: textEditingController,
                              onChanged: (value) {
                                textEditingController.text = value;
                                // setting cursor position
                                textEditingController.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset:
                                            textEditingController.text.length));
                              },
                              cursorColor: Colors.blue[400],
                              cursorWidth: 4.0,
                              cursorHeight: 20,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '검색할 제목을 입력해주세요.',
                                  labelStyle: GoogleFonts.nanumGothicCoding(
                                      color: Colors.black87,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.0))),
                        )),
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Expanded(
                        flex: 4,
                        child: ElevatedButton(
                          onPressed: () =>
                              searchWithTitle(textEditingController.text),
                          style: ElevatedButton.styleFrom(
                              primary: themeBlue,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              )),
                          child: Text("검색",
                              style: GoogleFonts.nanumGothicCoding(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0)),
                        ))
                  ],
                ),
        ),
        // title
        Positioned(
          top: 50.0,
          left: 100.0,
          child: Text('Working Paper',
              style: articleTitleTextStyle(color: Colors.white)),
        )
      ],
    );
  }
}
