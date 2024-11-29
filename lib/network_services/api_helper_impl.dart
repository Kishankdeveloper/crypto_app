import 'dart:developer';
import 'package:get/get.dart';
import '../utills/constants.dart';
import '../utills/storage.dart';
import 'api_helper.dart';


class ApiHelperImpl extends GetConnect implements ApiHelper{

  @override
  void onInit() {
    httpClient.baseUrl = Constants.baseUrl;
    httpClient.timeout = Constants.timeout;

    addRequestModifier();

    httpClient.addResponseModifier((request, response) {
      printInfo(
        info: 'Status Code: ${response.statusCode}\n'
            'Data: ${response.bodyString?.toString() ?? ''}',
      );

      return response;
    });
    super.onInit();
  }


  void addRequestModifier() {
    httpClient.addRequestModifier<dynamic>((request) {
      if (Storage.hasData(Constants.token)) {
        request.headers['Authorization'] = "Bearer " + Storage.getValue(Constants.token);
        request.headers['Accept'] ="application/json";
      }
      log("rest token ${request.headers} , ${request.url.path}");
      log("url daa ${request.url}");
      // printInfo(
      //   info: 'REQUEST ║ ${request.method.toUpperCase()}\n'
      //       'url: ${request.url}\n'
      //       'Headers: ${request.headers}\n'
      //       'Body: ${request.files?.toString() ?? ''}\n',
      // );

      return request;
    });
  }

  //below codes is for api calls initializer

  @override
  Future<Response> register(body) => post(Constants.registerUser, body);

  @override
  Future<Response> verifyOtp(body) => post(Constants.verifyOtp, body);

  @override
  Future<Response> login(body) => post(Constants.login, body);

  @override
  Future<Response> forgotPass(body) => post(Constants.forgotPass, body);

  @override
  Future<Response> updatePass(body) => post(Constants.updatePass, body);

  @override
  Future<Response> homeDashboard(body) => post(Constants.homeDashboard, body);

  @override
  Future<Response> startMining(body) => post(Constants.startMining, body);

  @override
  Future<Response> claimReward(body) => post(Constants.claimReward, body);

  @override
  Future<Response> swap(body) => post(Constants.swap, body);

  @override
  Future<Response> referList(body) => post(Constants.referList, body);

  @override
  Future<Response> getTasks(body) => post(Constants.getTasks, body);

  @override
  Future<Response> startTasks(body) => post(Constants.startTasks, body);

  @override
  Future<Response> claimTasks(body) => post(Constants.claimTasks, body);

  @override
  Future<Response> transactionHistory(body) => post(Constants.transactionHistory, body);

  @override
  Future<Response> usdtSuccess(body) => post(Constants.usdtSuccess, body);

  @override
  Future<Response> usdtReject(body) => post(Constants.usdtReject, body);

}