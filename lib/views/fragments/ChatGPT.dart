
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

import '../../../models/chatbot_model.dart';
import '../../common/validate_data.dart';


class ChatGPT extends StatefulWidget {

  const ChatGPT({Key? key}) : super(key: key);

  @override
  _ChatGPTState createState() => _ChatGPTState();
}

class _ChatGPTState extends State<ChatGPT> {

  bool _isMessageInput = false;
  bool _isMessageFull = false;
  ChatbotModel _chatbotModel = ChatbotModel();
  List<dynamic> _userMessage = [{"message": "En que puedo ayudarte?", "role": "bot"}];
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();

    super.dispose();
  }

  void _sendMessage() {
    String message = _textEditingController.text;
    _chatbotMessage(message);
    setState(() {
      _userMessage.add({"message": message, "role": "user"});
      _isMessageFull = true;
    });
    _textEditingController.clear();
  }

  void _clearMessage() {
    setState(() {
      _userMessage.clear();
      _isMessageFull = false;
      _isMessageInput = false;
    });
  }

  void _chatbotMessage(String message) async {
    print("Conectando al chat");
    var chatMessage = await ChatbotModel().getChatbotMessage(message);

    (Validate.isNotRequestError(chatMessage)) ? {
      _chatbotModel = chatMessage,
       setState(() {
        _userMessage.add({"message": _chatbotModel.message, "role": "bot"});
      }),
      print(_chatbotModel.message) }: _chatbotModel = ChatbotModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red,
          title:  const Center(child: Text('OpenAI', textAlign: TextAlign.center)),
          elevation: 0,
        ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                itemCount: _userMessage.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = _userMessage[index];
                  return ChatBubble(
                    clipper: (item['role'] == "user") ? ChatBubbleClipper1(type: BubbleType.sendBubble) : ChatBubbleClipper1(type: BubbleType.receiverBubble),
                    alignment: (item['role'] == "user") ? Alignment.topRight : Alignment.topLeft,
                    margin: const EdgeInsets.only(top: 13),
                    backGroundColor: (item['role'] == "user") ? Colors.blue : const Color(0xffE7E7ED),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      child: Text(
                        item['message'],
                        style: (item['role'] == "user") ? const TextStyle(color: Colors.white): const TextStyle(color: Colors.black),
                      ),
                    ),
                  );
                }
              )
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                _isMessageFull ? Container(
                  margin: const EdgeInsets.only(right: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: IconButton(
                    onPressed: () {
                      _clearMessage();
                    },
                    icon: const Icon(Icons.cleaning_services_outlined, color: Color(0xFF2A3EB0),),
                  ),
                ) : Container(),
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      hintText: "Escribe un mensaje",
                      // border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _isMessageInput = value.isNotEmpty;
                      });
                    },
                  ),
                ),
                (_isMessageInput) ? Container(
                  margin: const EdgeInsets.only(left: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        _sendMessage();
                      },
                      icon: const Icon(Icons.send, color: Color(0xFF2A3EB0),),
                    ),
                  ),
                ) : Container(),
              ],
            ),
          )
        ],
      )
    );
  }

}