import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:step_counter/core/constants/colors.dart';

class SignleMessage extends StatelessWidget {
  final String message;
  final Timestamp date;
  final bool isMe;

  const SignleMessage(
      {required this.message, required this.isMe, required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(2.4.w),
          margin: EdgeInsets.all(2.4.w),
          constraints: BoxConstraints(
            maxWidth: 40.h,
          ),
          decoration: BoxDecoration(
            color: isMe ? AppColors().darkGreen : AppColors().leftPurple,
            borderRadius: BorderRadius.circular(2.w),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 1.w),
                child:
                    Text(message, style: const TextStyle(color: Colors.white)),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.only(right: 1.w),
                child: Text("${date.toDate().hour}:${date.toDate().minute}",
                    style:
                        TextStyle(color: Colors.grey.shade300, fontSize: 13)),
              ),
            ],
          ),
        )
      ],
    );
  }
}
