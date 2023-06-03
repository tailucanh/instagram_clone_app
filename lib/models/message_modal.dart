import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Message {
  final String senderUid;
  final String senderName;
  final String message;
  final DateTime timestamp;

  Message({
    required this.senderUid,
    required this.senderName,
    required this.message,
    required this.timestamp,
  });

  Message.fromSnapshot(DocumentSnapshot snapshot)
      : senderUid = snapshot['senderUid'],
        senderName = snapshot['senderName'],
        message = snapshot['message'],
        timestamp = (snapshot['timestamp'] as Timestamp).toDate();

  Map<String, dynamic> toMap() {
    return {
      'senderUid': senderUid,
      'senderName': senderName,
      'message': message,
      'timestamp': timestamp,
    };
  }
}