import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

// Configure routes.
final _router = Router(notFoundHandler: _notFoundHandler)
  ..get('/', _rootHandler)
  ..get('/api/v1/check', _checkHandler)
  ..get('/api/v1/echo/<message>', _echoHandler)
  ..post('/api/v1/submit', _submitHandler);

final _headers = {'Content-Type': 'application/json'};

Response _rootHandler(Request req) {
  return Response.ok(
    json.encode({'message': 'Hello, World!'}),
    headers: _headers,
  );
}

// Ham xu ly yeu cau tai duong dan '/api/v1/check'
Response _checkHandler(Request req) {
  return Response.ok(
    json.encode({'message': 'Welcome to mobile web application'}),
    headers: _headers,
  );
}

Response _notFoundHandler(Request req) {
  return Response.notFound('Could not find "${req.url}" path on server');
}

Response _echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

Future<Response> _submitHandler(Request req) async {
  try {
    //Doc payload tu request
    final payload = await req.readAsString();

    // Giai ma JSON tu payload
    final data = await json.decode(payload);

    // Lay gia tri 'name' tu data, ep kieu ve String? neu co
    final name = data['name'] as String?;

    // Kiem tra neu 'name' hop le
    if (name != null && name.isNotEmpty) {
      //Tao phan hoi chao mung
      final response = {'message': 'Welcome $name'};

      //Tra ve phan hoi voi statusCode 200 va noi dung JSON
      return Response.ok(
        json.encode(response),
        headers: _headers,
      );
    } else {
      //Tao phan hoi yeu cau cung cap ten
      final response = {'message': 'Server khong nhan duoc ten cua ban'};

      // Tra ve phan hoi voi statusCode 400 va noi dung JSON
      return Response.badRequest(
        body: json.encode(response),
        headers: _headers,
      );
    }
  } catch (e) {
    // Xu ly ngoai le khi giai ma JSON
    final response = {'message': 'Request is invalid. Error ${e.toString()}'};

    return Response.badRequest(
      body: json.encode(response),
      headers: _headers,
    );
  }
}

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  final corsHeader = createMiddleware(requestHandler: (req) {
    if (req.method == 'OPTIONS') {
      return Response.ok('', headers: {
        // Cho phep moi nguon try cap (trong moi truong dev). Trong moi truong production chung ta nen thay * bang domain cu the.
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, PATCH, HEAD',
        'Access-Control-Allow-Headers': 'Content-Type, Authorization',
      });
    }
    return null;
  }, responseHandler: (res) {
    return res.change(headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, PATCH, HEAD',
      'Access-Control-Allow-Headers': 'Content-Type, Authorization',
    });
  });

  // Configure a pipeline that logs requests and middleware
  // final handler =
  //     Pipeline().addMiddleware(logRequests()).addHandler(_router.call);

  final handler = Pipeline()
      .addMiddleware(corsHeader)
      .addMiddleware(logRequests())
      .addHandler(_router.call);

  // For running in containers, we respect the PORT environment variable.
  // If env variable is not set, it will use the value from this variable. Otherwise, it will use the default value 8080.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
  print('Server running at http://${server.address.host}:${server.port}');
}
