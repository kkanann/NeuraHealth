import 'package:cloud_functions/cloud_functions.dart';

Future<String> getChatbotReply(String userInput) async {
  final HttpsCallable callable =
      FirebaseFunctions.instance.httpsCallable('getSmartReply');
  final response = await callable.call({'prompt': userInput});
  return response.data['reply'];
}

class Message {
  final String text;
  final bool isUser;

  Message({required this.text, required this.isUser});
}
