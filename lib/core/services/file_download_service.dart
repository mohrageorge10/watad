import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class FileDownloadService {
  final Dio _dio;

  FileDownloadService({Dio? dio}) : _dio = dio ?? Dio();

  Future<void> downloadAndOpenFile({
    required String url,
    required String fileName,
  }) async {
    try {
      // Get the appropriate directory for saving the file
      Directory? directory;
      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory();
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = await getDownloadsDirectory();
      }

      if (directory == null) {
        throw Exception("Could not find directory to save file");
      }

      final String savePath = '${directory.path}/$fileName';

      // Download the file
      await _dio.download(url, savePath);

      // Open the downloaded file
      final result = await OpenFile.open(savePath);
      
      if (result.type != ResultType.done) {
        throw Exception("Could not open file: ${result.message}");
      }
    } catch (e) {
      throw Exception("Failed to download or open file: $e");
    }
  }
}
