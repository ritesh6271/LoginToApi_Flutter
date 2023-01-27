
import 'package:dio/dio.dart';
import 'package:login_to_api/login/model/loginModel.dart';
import 'package:login_to_api/services/api/ApiEndPoint.dart';
import 'package:login_to_api/services/api/ApiHitter.dart';
import 'package:login_to_api/services/base/BaseRepository.dart';

class ApiController extends BaseRepository{
  Future<EmailModel> submitData({String ?email, String ?password})async{
    FormData formData =  FormData.fromMap({
      "email":email, "password":password
    });
    ApiResponse apiResponse = await apiHitter.getPostApiResponse(
      ApiEndpoint.postEmail,
      headers: {
        'Accept': "application/json",
        //'authorization': 'Bearer $userToken',
      },
      data: {},
        formData:formData,
        isFormData:true,
    );
    try {
      if (apiResponse.isSuccess ==false) {
        if (apiResponse.responseCode ==200  && apiResponse.response!.data != null) {
          final passEntity = EmailModel.fromJson(apiResponse.response!.data);
          return passEntity;
        } else {
          return EmailModel(
              code: apiResponse.responseCode, error:apiResponse.isSuccess , message: apiResponse.msg);
        }
      } else {
        if (apiResponse.responseCode == 422) {
          return EmailModel(
              code: apiResponse.responseCode, error:apiResponse.isSuccess , message: apiResponse.msg);
        }

        else {
          return EmailModel(
              code: apiResponse.responseCode, error:apiResponse.isSuccess , message: apiResponse.msg);
        }
      }
    } on DioError catch (error) {
      return EmailModel(
          code: apiResponse.responseCode, error:apiResponse.isSuccess , message: apiResponse.msg);
    }



  }
}