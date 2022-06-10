import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:step_counter/core/constants/texts.dart';
import 'package:step_counter/ui/pages/home/views/widgets/get_single_message.dart';

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
        actions: [
          CircleAvatar(
            radius: 5.w,
            backgroundImage: NetworkImage(profileUrl ?? AppTexts().profileUrl),
            backgroundColor: Colors.transparent,
          ),
        ],
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
              child: StreamBuilder(
                  stream: firebaseFirestore
                      .collection("chats")
                      .doc(firebaseAuth.currentUser?.uid)
                      .collection('messages')
                      .doc(widget.uid)
                      .collection('chats')
                      .orderBy("date", descending: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      var messages = snapshot.data.docs;

                      return ListView.builder(
                          itemCount: messages.length,
                          reverse: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: ((context, index) {
                            bool isMe = snapshot.data.docs[index]['senderId'] ==
                                firebaseAuth.currentUser?.uid;
                            return SignleMessage(
                              message: snapshot.data.docs[index]['message'],
                              isMe: isMe,
                              date: snapshot.data.docs[index]['date'],
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
              Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child: IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: () {
                    sendOldMessage();
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
