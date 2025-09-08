import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ModelLoader {
  static const String modelUrl =
      "https://huggingface.co/litert-community/Gemma3-1B-IT/resolve/main/gemma3-1b-it-int4.task"; // replace with actual .task model URL

  static const String modelFileName = "gemma-1b-4bit.task";

  /// Downloads the model only if not already present.
  static Future<File> getModelFile() async {
    final dir = await getApplicationDocumentsDirectory();
    final filePath = "${dir.path}/$modelFileName";
    final file = File(filePath);

    if (await file.exists()) {
      print("✅ Model already exists locally");
      return file;
    }

    print("⬇️ Downloading model...");
    final response = await http.get(Uri.parse(modelUrl));

    if (response.statusCode == 200) {
      await file.writeAsBytes(response.bodyBytes);
      print("✅ Model downloaded at $filePath");
      return file;
    } else {
      throw Exception("❌ Failed to download model: ${response.statusCode}");
    }
  }
}
