import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:note_app/screens/note_edit_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helper/note_provider.dart';
import '../widgets/note_list_item.dart';
import '../utils/constants.dart';

class NoteListScreen extends StatelessWidget {
  const NoteListScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<NoteProvider>(context, listen: false).getNotes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: Consumer<NoteProvider>(
                child: noNotesUI(context),
                builder: (context, noteprovider, child) =>
                    noteprovider.items.isEmpty
                        ? child as Widget
                        : ListView.builder(
                            itemCount: noteprovider.items.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return header();
                              } else {
                                final i = index - 1;
                                final item = noteprovider.items[i];
                                return ListItem(
                                  id: item.id,
                                  title: item.title,
                                  content: item.content,
                                  imagePath: item.imagePath,
                                  date: item.date,
                                );
                              }
                            },
                          ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  goToNoteEditScreen(context);
                },
                child: const Icon(Icons.add),
              ),
            );
          }
          return const SizedBox(
            width: 0.0,
            height: 0.0,
          );
        }
      },
    );
  }
}

Widget header() {
  return GestureDetector(
    onTap: _launchUrl,
    child: Container(
      decoration: const BoxDecoration(
        color: headerColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(75.0),
        ),
      ),
      height: 150,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'ITINERARY',
            style: headerItrenaryStyle,
          ),
          Text(
            'NOTES',
            style: headerNotesStyle,
          ),
        ],
      ),
    ),
  );
}

_launchUrl() async {
  const url = 'https://visitamhara.travel/';
  // ignore: deprecated_member_use
  if (await canLaunch(url)) {
    // ignore: deprecated_member_use
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Widget noNotesUI(BuildContext context) {
  return ListView(
    children: [
      header(),
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Image.asset(
              'assets/images/broken-heart.png',
              fit: BoxFit.cover,
              width: 200,
              height: 200,
            ),
          ),
          RichText(
            text: TextSpan(
              style: noNotesStyle,
              children: [
                const TextSpan(text: ' There is no note available\nTap on "'),
                TextSpan(
                    text: '+',
                    style: boldPlus,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        goToNoteEditScreen(context);
                      }),
                const TextSpan(text: '" to add new note'),
              ],
            ),
          )
        ],
      ),
    ],
  );
}

void goToNoteEditScreen(BuildContext context) {
  Navigator.of(context).pushNamed(NoteEditScreen.route);
}
