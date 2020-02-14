import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

typedef void OnUploadProgressCallback(int sent, int total);

HttpClient getHttpClient() {
  HttpClient httpClient = HttpClient()..connectionTimeout = const Duration(seconds: 10);

  return httpClient;
}

class CustomMultiPartRequest extends http.MultipartRequest {
  CustomMultiPartRequest(String method, Uri url, this.onProgress) : super(method, url);

  final void Function(int sent, int total) onProgress;

  @override
  http.ByteStream finalize() {
    final stream = super.finalize();

    if (onProgress == null) return stream;

    final total = this.contentLength;
    int sent = 0;

    final stream2 = stream.transform(StreamTransformer.fromHandlers(
      handleData: (data, EventSink<List<int>> sink) {
        sent += data.length;
        onProgress(sent, total);
        sink.add(data);
      },
      handleError: (error, stack, sink) {
        print(error.toString());
      },
      handleDone: (sink) {
        sink.close();
      },
    ));

    return http.ByteStream(stream2);
  }
}

Future<String> fileUpload({ File file, String folderPath, OnUploadProgressCallback onUploadProgress }) async {
  assert(file != null);

  final config = await rootBundle.loadString('config/cloudinary.json').then(jsonDecode);

  final String cloudName = config['cloud_name'];
  final url = 'https://api.cloudinary.com/v1_1/$cloudName/image/upload';

  final file2 = http.MultipartFile('file', file.openRead(), file.lengthSync(), filename: file.path.split('/').last);

  final request = CustomMultiPartRequest('post', Uri.parse(url), onUploadProgress)
    ..fields['upload_preset'] = config['upload_preset']
    ..fields['folder'] = folderPath
    ..files.add(file2);

  final http.StreamedResponse response = await request.send();

  if(response.statusCode > 400) throw Exception('image upload failed');

  final data = await utf8.decodeStream(response.stream).then(jsonDecode);

  return data['url'];
}
