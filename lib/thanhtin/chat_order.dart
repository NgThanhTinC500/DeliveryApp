import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Màu sắc chủ đạo
  final Color primaryGreen = const Color(0xFF6CC51D);
  final Color greyBubble = const Color(0xFFE0E0E0); // Màu nền tin nhắn người nhận
  final Color bgInput = const Color(0xFFF3F4F9);

  // Danh sách tin nhắn giả lập theo hình ảnh
  final List<Map<String, dynamic>> messages = [
    {
      "isMe": true,
      "text": "anh ơi gần đến chưa ?",
    },
    {
      "isMe": false,
      "text": "sắp đến rồi anh ơi, đợi em tí",
    },
    {
      "isMe": true,
      "text": "dạ anh đi cẩn thận",
    },
    {
      "isMe": false,
      "text": "dạ anh",
    },
    {
      "isMe": true,
      "text": "dạ tí em gửi thêm tiền",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 1. Header
            _buildHeader(),

            // 2. Message List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return _buildMessageItem(messages[index]);
                },
              ),
            ),

            // 3. Input Area
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  // --- Widgets con ---

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          // Back Button
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F4F8),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.black),
          ),
          const SizedBox(width: 20),
          // Title
          const Text(
            "Gia Bảo",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem(Map<String, dynamic> message) {
    bool isMe = message['isMe'];

    // Avatar người giao hàng (Driver)
    final String driverAvatar = "https://i.pravatar.cc/150?img=11";
    // Avatar người dùng (User - Boy)
    final String userAvatar = "https://cdn-icons-png.flaticon.com/512/4140/4140048.png";

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end, // Căn avatar xuống đáy dòng tin nhắn
        children: [
          // Nếu là người khác gửi -> Hiện Avatar bên trái
          if (!isMe) ...[
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(driverAvatar),
            ),
            const SizedBox(width: 10),
          ],

          // Bong bóng tin nhắn
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isMe ? primaryGreen : greyBubble,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: isMe ? const Radius.circular(20) : const Radius.circular(5),
                  bottomRight: isMe ? const Radius.circular(5) : const Radius.circular(20),
                ),
              ),
              child: Text(
                message['text'],
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black87,
                  fontSize: 15,
                ),
              ),
            ),
          ),

          // Nếu là tôi gửi -> Hiện Avatar bên phải
          if (isMe) ...[
            const SizedBox(width: 10),
            CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xFF2C3E50), // Màu nền avatar cho giống hình
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image.network(userAvatar),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      // decoration: const BoxDecoration(
      //   color: Colors.white, // Nếu muốn nền trắng cho thanh input
      // ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: 55,
              decoration: BoxDecoration(
                color: bgInput,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Icon(Icons.sentiment_satisfied_alt, color: Colors.grey[600], size: 28),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "write something ...",
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  // Send Button nằm trong thanh input
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          )
                        ]
                    ),
                    child: Transform.rotate(
                      angle: -0.5, // Xoay icon máy bay giấy một chút cho giống hình
                      child: const Icon(Icons.send, color: Colors.black, size: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}