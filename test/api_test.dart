import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';

void main() {
  test('API Test', () async {
    const token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2YjI0ZWE4My1iMjE1LTQyYTktYTFmMC1iMmI4ODExN2FhNWMiLCJqdGkiOiI5MzAwMTI4OS05MzU2LTRkMTAtYTkwYS0xZTJhMTMzZGMyMzEiLCJlbWFpbCI6ImF5YTEyNzk5N0BnbWFpbC5jb20iLCJ1bmlxdWVfbmFtZSI6ImF5YTEyNzk5N0BnbWFpbC5jb20iLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjZiMjRlYTgzLWIyMTUtNDJhOS1hMWYwLWIyYjg4MTE3YWE1YyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJheWEiLCJVc2VyVHlwZSI6Ik93bmVyIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiT3duZXIiLCJleHAiOjE3ODg3NDEwODUsImlzcyI6IldhdGFkQXBpIiwiYXVkIjoiV2F0YWRVc2VycyJ9.V0Z5AXdfC06jIT5-pGbVNIWwAoQ_U7A_mTycmatrKcQ";
    final url = "https://watad-c5c6hkgmcxe5dzeg.uaenorth-01.azurewebsites.net/api/Projects?PageNumber=1&PageSize=5";
    final dio = Dio();
    
    try {
      final response = await dio.get(
        url,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      print("Status Code: ${response.statusCode}");
      print("Response Data: ${response.data}");
    } catch (e) {
      print("Exception: $e");
    }
  });
}
