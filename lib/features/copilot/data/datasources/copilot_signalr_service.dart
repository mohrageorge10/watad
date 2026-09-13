import 'dart:async';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:logging/logging.dart';
import 'package:watad/core/cache/token_manager.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'package:watad/core/cache/secure_storage_helper.dart';
import 'package:signalr_netcore/ihub_protocol.dart';
import 'package:dio/dio.dart';

class NullSignalRArg {
  dynamic toJson() => null;
}

abstract class CopilotSignalRService {
  Future<void> initConnection();
  Stream<String> askCopilotStream(String projectId, String question, {String? sessionId});
  Future<void> stopConnection();
  bool get isConnected;
}

class CopilotSignalRServiceImpl implements CopilotSignalRService {
  HubConnection? _hubConnection;
  StreamController<String>? _streamController;
  
  // The user specified this URL in the spec
  final String _hubUrl = "http://watad-api.runasp.net/hubs/copilot";

  static bool _isLoggerInitialized = false;

  @override
  bool get isConnected => _hubConnection?.state == HubConnectionState.Connected;

  @override
  Future<void> initConnection() async {
    if (_hubConnection != null && _hubConnection!.state != HubConnectionState.Disconnected) {
      return;
    }

    print("📡 [SignalR] Starting connection...");

    // Pre-fetch token to verify it exists
    String? token = TokenManager.instance.token;
    token ??= CacheHelper().getData(key: CacheKeys.token) as String?;
    if (token == null || token.isEmpty) {
      token = await SecureStorageHelper().read(key: CacheKeys.token);
      if (token != null && token.isNotEmpty) {
        TokenManager.instance.setToken(token);
      }
    }

    print("📡 [SignalR] Token available: ${token != null && token.isNotEmpty}");
    if (token != null) {
      print("📡 [SignalR] Token length: ${token.length}");
      // --- Diagnostic Test ---
      print("📡 [SignalR] Running manual negotiate test...");
      try {
        final dio = Dio();
        dio.options.connectTimeout = const Duration(seconds: 10);
        dio.options.receiveTimeout = const Duration(seconds: 10);
        final response = await dio.post(
          "$_hubUrl/negotiate?negotiateVersion=1",
          options: Options(
            headers: {
              'Authorization': 'Bearer ${token.trim()}',
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
          ),
        );
        print("📡 [SignalR] HTTP manual negotiate status: ${response.statusCode}");
        print("📡 [SignalR] HTTP manual negotiate response: ${response.data}");
      } catch (e) {
        print("❌ [SignalR] HTTP manual negotiate failed: $e");
      }
      // --- End Diagnostic Test ---
    }

    final headers = MessageHeaders();
    headers.setHeaderValue('Accept', 'application/json');
    headers.setHeaderValue('Content-Type', 'application/json');

    if (!_isLoggerInitialized) {
      Logger.root.level = Level.ALL;
      Logger.root.onRecord.listen((LogRecord rec) {
        if (rec.loggerName.startsWith("SignalR")) {
          print('[${rec.level.name}] ${rec.loggerName}: ${rec.time}: ${rec.message}');
        }
      });
      _isLoggerInitialized = true;
    }

    _hubConnection = HubConnectionBuilder()
        .withUrl(_hubUrl,
            options: HttpConnectionOptions(
              headers: headers,
              accessTokenFactory: () async {
                String? t = TokenManager.instance.token;
                t ??= CacheHelper().getData(key: CacheKeys.token) as String?;
                if (t == null || t.isEmpty) {
                  t = await SecureStorageHelper().read(key: CacheKeys.token);
                  if (t != null && t.isNotEmpty) {
                    TokenManager.instance.setToken(t);
                  }
                }
                return (t ?? '').trim();
              },
              logger: Logger("SignalR - transport"),
            ))
        .withAutomaticReconnect()
        .configureLogging(Logger("SignalR - hub"))
        .build();

    _hubConnection?.onclose(({error}) {
      print("❌ [SignalR] Connection Closed: $error");
    });

    try {
      print("📡 [SignalR] Connecting to Copilot Hub...");
      await _hubConnection?.start();
      print("✅ [SignalR] Connected successfully");
    } catch (e) {
      print("❌ [SignalR] Connection failed: $e");
      rethrow;
    }
  }

  bool _isValidGuid(String id) {
    final guidRegex = RegExp(r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$');
    return guidRegex.hasMatch(id);
  }

  @override
  Stream<String> askCopilotStream(String projectId, String question, {String? sessionId}) {
    _streamController?.close();
    _streamController = StreamController<String>();

    if (!isConnected) {
      _streamController!.addError(Exception("SignalR is not connected."));
      return _streamController!.stream;
    }

    try {
      final cleanProjectId = projectId.trim();
      final isGuid = _isValidGuid(cleanProjectId);
      
      print("📡 [SignalR] Sending projectId: '$cleanProjectId' (Valid GUID: $isGuid)");
      print("📡 [SignalR] Sending question: '$question'");
      
      print("📡 [SignalR] projectId runtimeType: ${cleanProjectId.runtimeType}");
      print("📡 [SignalR] question runtimeType: ${question.runtimeType}");
      print("📡 [SignalR] sessionId runtimeType: ${sessionId?.trim().runtimeType}");
      
      // Stream invocation according to spec (must be exactly 3 arguments)
      // signalr_netcore requires List<Object>, so we use NullSignalRArg to pass null in JSON.
      final args = <Object>[
        cleanProjectId, 
        question, 
        sessionId?.trim() ?? NullSignalRArg(),
      ];
      
      print("📡 [SignalR] Starting AskCopilotStream with args: $args");

      final streamResult = _hubConnection?.stream("AskCopilotStream", args);
      
      streamResult?.listen(
        (item) {
          print("📥 [SignalR] Received chunk: $item");
          if (item != null) {
            _streamController?.add(item.toString());
          }
        },
        onError: (error) {
          print("❌ [SignalR] Stream error: $error");
          if (error is Exception) {
            print("❌ [SignalR] Stream Exception Details: ${error.toString()}");
          }
          _streamController?.addError(error);
          _streamController?.close();
        },
        onDone: () {
          print("✅ [SignalR] Stream completed");
          _streamController?.close();
        },
      );
    } catch (e) {
      _streamController?.addError(e);
    }

    return _streamController!.stream;
  }

  @override
  Future<void> stopConnection() async {
    await _hubConnection?.stop();
    _streamController?.close();
  }
}
