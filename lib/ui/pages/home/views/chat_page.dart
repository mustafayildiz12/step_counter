import 'package:flutter/material.dart';
import 'package:step_counter/core/models/chat_model.dart';

import '../view_models.dart/chat_page_model.dart';
import 'bottom_navigation_page.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ChatPageModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            routes.navigateToWidget(context, const BottomNavigationPage());
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<List<ChatModel>>(
                  stream: readMessages(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var messages = snapshot.data;
                      print(messages?.length);

                      return ListView.builder(
                          itemCount: messages?.length,
                          itemBuilder: ((context, index) {
                            return Text(
                              messages?[0].message ?? 'empty message',
                              style: const TextStyle(color: Colors.white),
                            );
                          }));
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                    }
                    return const CircularProgressIndicator();
                  })),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: t1,
                  decoration: const InputDecoration(
                      filled: true, fillColor: Colors.amber),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.send,
                  color: Colors.blueGrey,
                ),
                onPressed: () {
                  send();
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
