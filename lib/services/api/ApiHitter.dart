import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'ApiEndPoint.dart';
import 'logging_intercepter.dart';


class ApiHitter {
  static Dio ?_dio;
  static CancelToken ?_cancelToken;
  final GlobalKey key = GlobalKey();
  static Dio getDio() {
    if (_dio == null) {
      _dio = Dio();
      _cancelToken = CancelToken();
      BaseOptions options = BaseOptions(
          baseUrl: ApiEndpoint.baseUrl,
          connectTimeout: 300000,
          receiveTimeout: 300000);
      // _dio.interceptors.add(PrettyDioLogger());
      _dio!.options = options;
      return _dio!..interceptors.add(LoggingInterceptor());
    } else {
      return _dio!;
    }
  }
  //..........................................get api.........................................................
  Future<ApiResponse> getApiResponse(String endPoint,
      {Map<String, dynamic> ?headers, Map<String, dynamic> ?queryParams}) async {


    try {

      final result = await InternetAddress.lookup('google.com');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Response response = await getDio().get(endPoint,
            options: Options(headers: headers), queryParameters: queryParams);
        if (response.statusCode == 200) {
          if (response.data["code"] == 200 && response.data["error"] == false) {
            return ApiResponse(isSuccess:response.data["error"], responseCode:response.data["code"],
                response: response, msg: response.data["message"]);
          } else {
            return ApiResponse(isSuccess:response.data["error"], responseCode:response.data["code"],
                response: response, msg: response.data["message"]);
          }
        }else if(response.statusCode == 403){
          String indexkek=response.data["message"].keys.first;
          return ApiResponse(isSuccess:response.data["error"], responseCode:response.data["code"],
              response:response.data["message"] is String ?response.data["message"]: response, msg: response.data["message"][indexkek]);
        }
        else {
          return ApiResponse(isSuccess:response.data["error"], responseCode:response.data["code"],
              response: response, msg: response.data["message"]);
        }
      } else {
        return ApiResponse(isSuccess:false, responseCode:301, msg: "no internate connection");
      }
    } on DioError catch (error) {
      if (error.type == DioErrorType.response) {
        print('catched');

        if(error.response!.statusCode==403){
          String indexkek=error.response!.data["message"].keys.first;
          return ApiResponse(isSuccess:error.response!.data["error"], responseCode:error.response!.statusCode,

              msg:error.response!.data["message"] is String ?error.response!.data["message"]: error.response!.data["message"][indexkek]
          );

        }else{
          return ApiResponse(isSuccess:false, responseCode:error.response!.statusCode,

              msg: error.response!.statusMessage.toString()
          );
        }

      }
      if (error.type == DioErrorType.connectTimeout) {
        print('check your connection');
        return ApiResponse(isSuccess:false, responseCode:error.response!.statusCode,
            msg: error.response!.data["message"]);
      }

      if (error.type == DioErrorType.receiveTimeout) {
        print('unable to connect to the server');
        return ApiResponse(isSuccess:false, responseCode:error.response!.statusCode,
            msg: error.response!.data["message"]);
      }

      if (error.type == DioErrorType.other) {
        print('Something went wrong');
        return ApiResponse(isSuccess:false, responseCode:400,
            msg: "wrong api url");
      }
      print("error checking by mk ${error}");
    }on SocketException catch (_) {
      return ApiResponse(isSuccess:false, responseCode:300,
          msg: "Please check your internate connection");
    } catch (error) {
      return ApiResponse(isSuccess:false, responseCode:400,
          msg: "technical issue");

    }
    return ApiResponse();

  }
//......................................post put.......................................................
  Future<ApiResponse> getPostApiResponse(String endPoint,
      {Map<String, dynamic> ?headers,
        Map<String, dynamic> ?data,
        FormData ?formData,
        bool isFormData = false}) async {
    try {

      final result = await InternetAddress.lookup('google.com');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var response = await getDio().post(endPoint,
            options: Options(headers: headers),
            data: isFormData ? formData : data,
            onSendProgress: (int sent, int total) {});


        if (response.statusCode == 200) {
          if (response.data["code"] == 200 && response.data["error"] == false) {
            return ApiResponse(isSuccess:response.data["error"], responseCode:response.data["code"],
                response: response, msg: response.data["message"]);
          } else {
            return ApiResponse(isSuccess:response.data["error"], responseCode:response.data["code"],
                response: response, msg: response.data["message"]);
          }
        }else if(response.statusCode == 403){
          String indexkek=response.data["message"].keys.first;
          return ApiResponse(isSuccess:response.data["error"], responseCode:response.data["code"],
              response:response.data["message"] is String ?response.data["message"]: response, msg: response.data["message"][indexkek]);
        }
        else {
          String indexkek=response.data["message"].keys.first;
          return ApiResponse(isSuccess:response.data["error"], responseCode:response.data["code"],
              response: response, msg: response.data["message"]);
        }


      } else {
        return ApiResponse(isSuccess:true, responseCode:300, msg: "no internate connection");
      }


    } on DioError catch (error) {

      if (error.type == DioErrorType.response) {
        print('my catched');
        if(error.response!.statusCode==400){
          if(error.response!.data["message"] is String){
            return ApiResponse(isSuccess:true, responseCode:error.response!.statusCode,
                msg: error.response!.data["message"]
            );
          }else{
            String indexkek=error.response!.data["message"].keys.first;
            return ApiResponse(isSuccess:true, responseCode:error.response!.statusCode,

                msg: error.response!.data["message"][indexkek]
            );
          }


        }else if(error.response!.statusCode==401){
          String indexkek=error.response!.data["message"].keys.first;
          return ApiResponse(isSuccess:true, responseCode:error.response!.statusCode,
              // msg: error.response!.data["message"]
              msg:error.response!.data["message"] is String ?error.response!.data["message"]: error.response!.data["message"][indexkek]
          );
        }else if(error.response!.statusCode==404){
          String indexkek=error.response!.data["message"].keys.first;
          return ApiResponse(isSuccess:true, responseCode:error.response!.statusCode,
              // msg: error.response!.data["message"]
              msg:error.response!.data["message"] is String ?error.response!.data["message"]: error.response!.data["message"][indexkek]
          );
        }
        else if(error.response!.statusCode==422){
          String indexkek=error.response!.data["message"].keys.first;
          return ApiResponse(isSuccess:true, responseCode:error.response!.statusCode,
              msg:error.response!.data["message"] is String ?error.response!.data["message"]: error.response!.data["message"][indexkek]

          );
        }
        else{
          return ApiResponse(isSuccess:true, responseCode:error.response!.statusCode,
              // msg: error.response!.data["message"]
              msg: error.response!.statusMessage.toString()
          );
        }

      }
      if (error.type == DioErrorType.connectTimeout) {
        print('check your connection');
        return ApiResponse(isSuccess:true, responseCode:300,
            msg: "Connecting timed out");
      }

      if (error.type == DioErrorType.receiveTimeout) {
        print('unable to connect to the server');
        return ApiResponse(isSuccess:true, responseCode:error.response!.statusCode,
            msg: error.response!.data["message"]);
      }

      if (error.type == DioErrorType.other) {
        print('Something went wrong');
        return ApiResponse(isSuccess:true, responseCode:400,
            msg: "something went wrong");
      }
      print("error checking by mk ${error}");


      /*return ApiResponse(isSuccess:false, responseCode:error.response!.statusCode,
          msg: error.response!.data["message"]);*/
    }on SocketException catch (_) {
      return ApiResponse(isSuccess:true, responseCode:300,
          msg: "Please check your internate connection");
    } catch (error) {
      return ApiResponse(isSuccess:true, responseCode:400,
          msg: "technical issue");

    }
    return ApiResponse();
  }
  /* Future<ApiResponse> getApiResponse(String endPoint,
      {Map<String, dynamic> ?headers, Map<String, dynamic> ?queryParams}) async {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      try {
        Response response = await getDio().get(endPoint,
            options: Options(headers: headers), queryParameters: queryParams);
        if (response.statusCode == 200) {
          if (response.data["status"] == 200)
            return ApiResponse(true, response.data["status"],
                response: response, msg: response.data["message"]);
          else
            return ApiResponse(false, response.data["status"],
                response: response, msg: response.data["message"]);
        } else
          return ApiResponse(false, response.statusCode!,
              response: response, msg: response.statusMessage!);
      } catch (error) {
        return ApiResponse(false, 401,
            msg: "catch error");
      }
    } else
      return ApiResponse(false, 301, msg: error_no_internet);
  }
  Future<ApiResponse> getPostApiResponse(String endPoint,
      {Map<String, dynamic> ?headers,
        Map<String, dynamic> ?data,
        FormData ?formData,
        bool isFormData = false}) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var response = await getDio().post(endPoint,
            options: Options(headers: headers),
            data: isFormData ? formData : data,
            onSendProgress: (int sent, int total) {});
        if (response.statusCode == 200) {
          if (response.data["status"] == 200)
            return ApiResponse(true, response.data["status"],
                response: response, msg: response.data["message"]);
          else
            return ApiResponse(false, response.data["status"],
                response: response, msg: response.data["message"]);
        } else
          return ApiResponse(false, response.statusCode!,
              response: response, msg: response.statusMessage!);
      } else
        return ApiResponse(false, 301, msg: error_no_internet);
    } catch (error) {
      return ApiResponse(false, 401,
          msg: "catch error");
    }
  }*/

  void cancelRequests({CancelToken ?cancelToken}) {
    cancelToken == null
        ? _cancelToken!.cancel('Cancelled')
        : cancelToken.cancel();
  }
}

/*class LoggingInterceptor {
}*/

class ApiResponse {
  final bool ?isSuccess;
  final int ?responseCode;
  final String ?msg;
  final Response ?response;

  ApiResponse({this.isSuccess, this.responseCode,
    this.msg, this.response});
}