class InstructionResponse {
  final String instruction;
  final ResponseData response;

  InstructionResponse({required this.instruction, required this.response});

  factory InstructionResponse.fromJson(Map<String, dynamic> json) {
    return InstructionResponse(
      instruction: json['instruction'] ?? '',
      response: ResponseData.fromJson(json['response'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {'instruction': instruction, 'response': response.toJson()};
  }
}

class ResponseData {
  final String text;
  final List<ActionData> actions;

  ResponseData({required this.text, required this.actions});

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      text: json['text'] ?? '',
      actions:
          (json['actions'] as List<dynamic>? ?? [])
              .map((a) => ActionData.fromJson(a))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'actions': actions.map((a) => a.toJson()).toList()};
  }
}

class ActionData {
  final String type;
  final Map<String, dynamic> parameters;

  ActionData({required this.type, required this.parameters});

  factory ActionData.fromJson(Map<String, dynamic> json) {
    return ActionData(
      type: json['type'] ?? '',
      parameters: Map<String, dynamic>.from(json['parameters'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'parameters': parameters};
  }
}
