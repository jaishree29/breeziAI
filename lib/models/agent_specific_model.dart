class BluetoothParams {
  final String state;
  BluetoothParams({required this.state});

  factory BluetoothParams.fromJson(Map<String, dynamic> json) {
    return BluetoothParams(state: json['state'] ?? '');
  }

  Map<String, dynamic> toJson() => {'state': state};
}

class WifiParams {
  final String state;
  final String? ssid;
  final String? password;

  WifiParams({required this.state, this.ssid, this.password});

  factory WifiParams.fromJson(Map<String, dynamic> json) {
    return WifiParams(
      state: json['state'] ?? '',
      ssid: json['ssid'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
    'state': state,
    if (ssid != null) 'ssid': ssid,
    if (password != null) 'password': password,
  };
}

class AppParams {
  final String packageName;

  AppParams({required this.packageName});

  factory AppParams.fromJson(Map<String, dynamic> json) {
    return AppParams(packageName: json['packageName'] ?? '');
  }

  Map<String, dynamic> toJson() => {'packageName': packageName};
}

class EmailParams {
  final String packageName;
  final String to;
  final String subject;
  final String body;

  EmailParams({
    required this.packageName,
    required this.to,
    required this.subject,
    required this.body,
  });

  factory EmailParams.fromJson(Map<String, dynamic> json) {
    return EmailParams(
      packageName: json['packageName'] ?? '',
      to: json['to'] ?? '',
      subject: json['subject'] ?? '',
      body: json['body'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'packageName': packageName,
    'to': to,
    'subject': subject,
    'body': body,
  };
}

class CalendarParams {
  final String packageName;
  final String title;
  final String time;
  final String? location;

  CalendarParams({
    required this.packageName,
    required this.title,
    required this.time,
    this.location,
  });

  factory CalendarParams.fromJson(Map<String, dynamic> json) {
    return CalendarParams(
      packageName: json['packageName'] ?? '',
      title: json['title'] ?? '',
      time: json['time'] ?? '',
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() => {
    'packageName': packageName,
    'title': title,
    'time': time,
    if (location != null) 'location': location,
  };
}

class CallParams {
  final String phoneNumber;

  CallParams({required this.phoneNumber});

  factory CallParams.fromJson(Map<String, dynamic> json) {
    return CallParams(phoneNumber: json['phoneNumber'] ?? '');
  }

  Map<String, dynamic> toJson() => {'phoneNumber': phoneNumber};
}

class SmsParams {
  final String phoneNumber;
  final String message;

  SmsParams({required this.phoneNumber, required this.message});

  factory SmsParams.fromJson(Map<String, dynamic> json) {
    return SmsParams(
      phoneNumber: json['phoneNumber'] ?? '',
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'phoneNumber': phoneNumber,
    'message': message,
  };
}

class DndParams {
  final String startTime;
  final String endTime;
  final List<String> exceptions;

  DndParams({
    required this.startTime,
    required this.endTime,
    required this.exceptions,
  });

  factory DndParams.fromJson(Map<String, dynamic> json) {
    return DndParams(
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
      exceptions: List<String>.from(json['exceptions'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
    'start_time': startTime,
    'end_time': endTime,
    'exceptions': exceptions,
  };
}
