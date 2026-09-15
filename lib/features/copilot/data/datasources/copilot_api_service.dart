import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:watad/core/network/api/end_points.dart';
import 'package:watad/core/cache/token_manager.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'package:watad/features/copilot/data/models/chat_session_summary_dto.dart';
import 'package:watad/features/copilot/data/models/chat_message_dto.dart';
import 'package:watad/features/copilot/data/models/copilot_chat_response_dto.dart';

abstract class CopilotApiService {
  Future<List<ChatSessionSummaryDto>> getSessions(String projectId);
  Future<List<ChatMessageDto>> getSessionMessages(String projectId, String sessionId);
  Future<CopilotChatResponseDto> askCopilotFallback(String projectId, String question, {String? sessionId});
}

class CopilotApiServiceImpl implements CopilotApiService {
  
  CopilotApiServiceImpl();

  Future<Map<String, String>> _getHeaders() async {
    String? token = TokenManager.instance.token;
    token ??= CacheHelper().getData(key: CacheKeys.token) as String?;
    
    return {
      'Accept': 'application/json',
      'Accept-Language': 'ar,ar-EG;q=0.9,en;q=0.8',
      'Content-Type': 'application/json; charset=UTF-8',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  @override
  Future<List<ChatSessionSummaryDto>> getSessions(String projectId) async {
    final headers = await _getHeaders();
    final url = Uri.parse('${EndPoints.baseUrl}${EndPoints.copilotSessions(projectId)}');
    final response = await http.get(url, headers: headers);
    
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));
      if (decodedData is List) {
        return decodedData.map((e) => ChatSessionSummaryDto.fromJson(e)).toList();
      }
      if (decodedData['data'] != null && decodedData['data'] is List) {
        return (decodedData['data'] as List).map((e) => ChatSessionSummaryDto.fromJson(e)).toList();
      }
    }
    return [];
  }

  @override
  Future<List<ChatMessageDto>> getSessionMessages(String projectId, String sessionId) async {
    final headers = await _getHeaders();
    final url = Uri.parse('${EndPoints.baseUrl}${EndPoints.copilotSessionMessages(projectId, sessionId)}');
    final response = await http.get(url, headers: headers);
    
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));
      if (decodedData is List) {
        return decodedData.map((e) => ChatMessageDto.fromJson(e)).toList();
      }
      if (decodedData['data'] != null && decodedData['data'] is List) {
        return (decodedData['data'] as List).map((e) => ChatMessageDto.fromJson(e)).toList();
      }
    }
    return [];
  }

  @override
  Future<CopilotChatResponseDto> askCopilotFallback(String projectId, String question, {String? sessionId}) async {
    final headers = await _getHeaders();
    final url = Uri.parse('${EndPoints.baseUrl}${EndPoints.copilotAsk(projectId)}');
    
    final body = {
      'projectId': projectId,
      'question': question,
      if (sessionId != null) 'sessionId': sessionId,
    };

    print("🌐 [REST POST] Fallback calling /api/projects/$projectId/copilot/ask");
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    
    print("🌐 [REST RESPONSE] Status: ${response.statusCode}, Body:${utf8.decode(response.bodyBytes)}");
    
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonBody = jsonDecode(utf8.decode(response.bodyBytes));
      final responseData = jsonBody['data'] ?? jsonBody;
      return CopilotChatResponseDto.fromJson(responseData);
    }
    
    throw Exception('Failed to get fallback response');
  }
}
