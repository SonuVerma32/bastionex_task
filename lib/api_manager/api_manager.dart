import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'api_response/response_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';
import 'package:http/io_client.dart';

Future<SecurityContext> get globalContext async {
  final sslCert = await rootBundle.load('assets/ssl_certificate.pem');
  SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
  return securityContext;
}

Future<http.Client> getSSLPinningClient() async {
  HttpClient client = HttpClient(context: await globalContext);
  client.badCertificateCallback =
      (X509Certificate cert, String host, int port) => false;
  IOClient ioClient = IOClient(client);
  return ioClient;
}

class ApiManager {
  final String _baseUrl =
      "https://uat-nftbe.metaspacechain.com/nftmarketplace/api/v1/";

  onException() {
    return ResponseModel(
        data: null, message: "Internal server error", statusCode: 500);
  }

  Future<dynamic> getData() async {
    try {
      final http.Client client = await getSSLPinningClient();
      final uri = Uri.parse('${_baseUrl}test/get_all_nfts');
      final response = await client.get(uri);
      log(response.body);
      return response;
    } on SocketException {
      return onException();
    }
  }

  ResponseModel _response(http.Response response) {
    ResponseModel responseModel;
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        responseModel = ResponseModel(
            data: responseJson,
            message: responseJson["message"],
            statusCode: 200);
        return responseModel;
      case 201:
        var responseJson = json.decode(response.body.toString());
        responseModel = ResponseModel(
            data: responseJson,
            message: responseJson["message"],
            statusCode: 200);
        return responseModel;
      case 203:
        var responseJson = json.decode(response.body.toString());
        responseModel = ResponseModel(
            data: responseJson,
            message: responseJson["message"],
            statusCode: 203);
        return responseModel;
      case 204:
        responseModel = ResponseModel(
            data: "responseJson",
            message: "Something went wrong!",
            statusCode: 204);
        return responseModel;
      case 208:
        var responseJson = json.decode(response.body.toString());
        responseModel = ResponseModel(
            data: responseJson,
            message: responseJson["message"],
            statusCode: 208);
        return responseModel;
      case 404:
        var responseJson = json.decode(response.body.toString());
        responseModel = ResponseModel(
            data: responseJson,
            message: responseJson["message"],
            statusCode: 404);
        return responseModel;
      case 500:
        try {
          var responseJson = json.decode(response.body.toString());
          responseModel = ResponseModel(
              data: responseJson,
              message: responseJson["message"],
              statusCode: 500);
        } catch (e) {
          responseModel = ResponseModel(
              data: null, message: "Internal server error", statusCode: 500);
        }
        return responseModel;
      default:
        try {
          var responseJson = json.decode(response.body.toString());
          responseModel = ResponseModel(
              data: null,
              message: responseJson["message"],
              statusCode: response.statusCode);
        } catch (e) {
          responseModel = ResponseModel(
              data: null, message: "Internal server error", statusCode: 500);
        }
        return responseModel;
    }
  }
}
