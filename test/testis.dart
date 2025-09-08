import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mediapipe_genai/mediapipe_genai.dart';
import 'package:path_provider/path_provider.dart';

// This is a placeholder URL. You will need to download a model from Kaggle
// and host it on a server for your app to download.
// Example models can be found on Kaggle: https://www.kaggle.com/models?tab=community&tags=mediapipe
const String modelUrl =
    'https://huggingface.co/litert-community/Gemma3-1B-IT/resolve/main/gemma3-1b-it-int4.task';
const String modelFileName = 'gemma-1b-4bit.task';

void main() async{
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local LLM with MediaPipe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // State variables to track the app's status.
  String _status = 'Initializing...';
  bool _isLlmReady = false;
  LlmInferenceEngine? _engine;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  /// Handles the entire app initialization, including model download and engine setup.
  Future<void> _initializeApp() async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String modelPath = '${appDocDir.path}/$modelFileName';
    final File modelFile = File(modelPath);

    if (await modelFile.exists()) {
      _status = 'Model already downloaded. Initializing LLM...';
      await _initializeLlm(modelPath);
    } else {
      _status = 'Model not found. Starting download...';
      await _downloadModel(modelFile);
    }
  }

  /// Downloads the LLM model from the internet and saves it locally.
  Future<void> _downloadModel(File modelFile) async {
    try {
      final response = await http.get(
        Uri.parse(modelUrl),
        headers: {'Authorization': 'Bearer ${dotenv.env['accessToken']}'},
      );
      print(response.body);
      if (response.statusCode == 200) {
        
        await modelFile.writeAsBytes(response.bodyBytes);
        _status = 'Download complete. Initializing LLM...';
        await _initializeLlm(modelFile.path);

      } else {
        _status = 'Error downloading model. Status: ${response.statusCode}';
      }
    } catch (e) {
      _status = 'An error occurred during download: $e';
    }
    setState(() {});
  }

  /// Initializes the MediaPipe LLM Inference Engine with the local model.
  Future<void> _initializeLlm(String modelPath) async {
    try {
      final LlmInferenceOptions options = LlmInferenceOptions.cpu(
        modelPath: modelPath,
        cacheDir: (await getApplicationCacheDirectory()).path,
        maxTokens: 512,
        temperature: 0.8,
        topK: 40,
      );
      _engine = LlmInferenceEngine(options);
      _isLlmReady = true;
      _status = 'LLM is ready to use!';
    } catch (e) {
      _status = 'Failed to initialize LLM: $e';
    }
    setState(() {});
  }

  /// Simulates a gesture and uses the local LLM to generate a response.
  Future<void> _processGesture() async {
    if (!_isLlmReady || _engine == null) {
      _status = 'LLM is not ready yet.';
      setState(() {});
      return;
    }

    // Simulate a MediaPipe-detected gesture.
    const String detectedGesture = 'a wave hello';
    final String prompt =
        "The user performed a '$detectedGesture'. Provide a brief greeting in response.";

    _status = 'Generating response from local LLM...';
    setState(() {});

    try {
      // Use the local LLM to generate the response.
      final Stream<String> llmResponse = _engine!.generateResponse(prompt);
      _status = 'LLM says: "$llmResponse"';
    } catch (e) {
      _status = 'Error generating response: $e';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Local LLM with MediaPipe'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Status:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(_status, textAlign: TextAlign.center),
              const SizedBox(height: 20),
              if (!_isLlmReady)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _processGesture,
                  child: const Text('Simulate Gesture'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
