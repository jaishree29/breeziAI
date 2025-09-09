// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Hugging Face Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const TextSummarizerPage(),
//     );
//   }
// }

// class TextSummarizerPage extends StatefulWidget {
//   const TextSummarizerPage({super.key});

//   @override
//   State<TextSummarizerPage> createState() => _TextSummarizerPageState();
// }

// class _TextSummarizerPageState extends State<TextSummarizerPage> {
//   // Your Hugging Face API key
//   final String _apiKey = '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';
//   // The API endpoint for the summarization model (e.g., BART)
//   final String _apiUrl = 'https://router.huggingface.co/v1/chat/completions';

//   // Example input text for summarization
//   final String _inputText = "What is the capital of India?";

//   late Future<List<dynamic>> _summaryFuture;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize the future when the widget is first created
//     _summaryFuture = _getSummary(_inputText);
//   }

//   // Asynchronous function to call the Hugging Face API
//   Future<List<dynamic>> _getSummary(String text) async {
//     final response = await http.post(
//       Uri.parse(_apiUrl),
//       headers: {
//         'Authorization': 'Bearer $_apiKey',
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         "model": 'openai/gpt-oss-120b:cerebras',
//         "messages": [
//           {"role": "user", "content": _inputText},
//         ],
//       }),
//     );
//     print(response);
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       final message = data['choices'][0]['message']['content'];
//       print(message);
//       return message;
//     } else {
//       // Throw an exception for non-200 status codes
//       throw Exception(
//         'Failed to load summary. Status code: ${response.statusCode}',
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: const Text('Hugging Face API Demo'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'You:',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),
//               Container(
//                 padding: const EdgeInsets.all(12.0),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: Text(_inputText),
//               ),
//               const SizedBox(height: 24),
//               const Text(
//                 'Answer:',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),
//               // Use FutureBuilder to handle the async API call and UI updates
//               FutureBuilder<List<dynamic>>(
//                 future: _summaryFuture,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Text('Error: ${snapshot.error}');
//                   } else if (snapshot.hasData) {
//                     final summary = snapshot.data![0]['summary_text'];
//                     return Container(
//                       padding: const EdgeInsets.all(12.0),
//                       decoration: BoxDecoration(
//                         color: Colors.lightGreen[100],
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                       child: Text(summary),
//                     );
//                   } else {
//                     return const Text('No data found.');
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:convert';
// import 'package:flutter/foundation.dart'; // For kDebugMode
// import 'package:http/http.dart' as http;

// /// This class encapsulates the logic for making API calls to Hugging Face
// /// endpoints that are compatible with the OpenAI API.
// class HuggingFaceClient {
//   final String _baseUrl;
//   final String _apiKey;

//   HuggingFaceClient({
//     required String baseUrl,
//     required String apiKey,
//   })  : _baseUrl = baseUrl,
//         _apiKey = apiKey;

//   /// Creates a chat completion using a Hugging Face model.
//   ///
//   /// The payload is formatted to be compatible with the OpenAI chat API.
//   Future<String> createChatCompletion({
//     required String model,
//     required String content,
//   }) async {
//     final Map<String, dynamic> body = {
//       "model": model,
//       "messages": [
//         {
//           "role": "user",
//           "content": content,
//         }
//       ],
//     };

//     try {
//       final response = await http.post(
//         Uri.parse(_baseUrl),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $_apiKey',
//         },
//         body: jsonEncode(body),
//       );
//       print(response.body);
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final message = data['choices'][0]['message']['content'];
//         return message;
//       } else {
//         // Log the error in debug mode for more details
//         if (kDebugMode) {
//           print('API Error: ${response.statusCode}');
//           print('Response Body: ${response.body}');
//         }
//         throw Exception(
//             'Failed to get chat completion. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print('Network Error: $e');
//       }
//       throw Exception('An error occurred while making the request.');
//     }
//   }
// }

// // Example of how to use the client
// void main() async {
//   // IMPORTANT: Replace with your actual base URL and API key
//   const String baseUrl = "https://router.huggingface.co/v1/chat/completions";
//   const String apiKey = "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";
//   const String model = "openai/gpt-oss-120b:cerebras";
//   const String prompt = "What is the capital of India?";

//   final client = HuggingFaceClient(
//     baseUrl: baseUrl,
//     apiKey: apiKey,
//   );

//   try {
//     print('Calling API...');
//     final response = await client.createChatCompletion(
//       model: model,
//       content: prompt,
//     );
//     print('API Response: $response');
//   } catch (e) {
//     print('Failed to get a response: $e');
//   }
// }



import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const ChatApp());
}

/// This class encapsulates the logic for making API calls to Hugging Face
/// endpoints that are compatible with the OpenAI API.
class HuggingFaceClient {
  final String _baseUrl;
  final String _apiKey;

  HuggingFaceClient({
    required String baseUrl,
    required String apiKey,
  })  : _baseUrl = baseUrl,
        _apiKey = apiKey;

  /// Creates a chat completion using a Hugging Face model.
  ///
  /// The payload is formatted to be compatible with the OpenAI chat API.
  Future<String> createChatCompletion({
    required String model,
    required String content,
  }) async {
    final Map<String, dynamic> body = {
      "model": model,
      "messages": [
        {
          "role": "user",
          "content": content,
        }
      ],
    };

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final message = data['choices'][0]['message']['content'];
        return message;
      } else {
        // Log the error in debug mode for more details
        if (kDebugMode) {
          print('API Error: ${response.statusCode}');
          print('Response Body: ${response.body}');
        }
        throw Exception(
            'Failed to get chat completion. Status code: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Network Error: $e');
      }
      throw Exception('An error occurred while making the request.');
    }
  }
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat with AI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 0, 255)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false, 
      home: const ChatScreen(),
    );
  }
}


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _textController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  // IMPORTANT: Replace with your actual credentials and model details
  final _client = HuggingFaceClient(
    baseUrl: "https://router.huggingface.co/v1/chat/completions",
    apiKey: "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",
  );
  final String _model = "openai/gpt-oss-120b:cerebras";

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final userMessage = _textController.text.trim();
    if (userMessage.isEmpty || _isLoading) return;

    setState(() {
      _messages.add({'role': 'user', 'content': userMessage});
      _textController.clear();
      _isLoading = true;
    });

    try {
      final aiResponse = await _client.createChatCompletion(
        model: _model,
        content: userMessage,
      );
      setState(() {
        _messages.add({'role': 'assistant', 'content': aiResponse});
      });
    } catch (e) {
      setState(() {
        _messages.add({'role': 'assistant', 'content': 'Error: $e'});
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BreezeiAI'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                final isUser = message['role'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue[100] : Colors.grey[200],
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(20),
                        topRight: const Radius.circular(20),
                        bottomLeft: isUser ? const Radius.circular(20) : const Radius.circular(0),
                        bottomRight: isUser ? const Radius.circular(0) : const Radius.circular(20),
                      ),
                    ),
                    child: Text(
                      message['content']!,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          const Divider(height: 1),
          _buildTextComposer(),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Send a message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              ),
              onSubmitted: (text) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            onPressed: _isLoading ? null : _sendMessage,
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            child: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}