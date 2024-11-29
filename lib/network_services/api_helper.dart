import 'package:get/get.dart';

abstract class ApiHelper{

  static ApiHelper get to => Get.find();

  Future<Response> register(body);

  Future<Response> verifyOtp(body);

  Future<Response> login(body);

  Future<Response> forgotPass(body);

  Future<Response> updatePass(body);

  Future<Response> homeDashboard(body);

  Future<Response> startMining(body);

  Future<Response> claimReward(body);

  Future<Response> swap(body);

  Future<Response> referList(body);

  Future<Response> getTasks(body);

  Future<Response> startTasks(body);

  Future<Response> claimTasks(body);

  Future<Response> transactionHistory(body);

  Future<Response> usdtSuccess(body);

  Future<Response> usdtReject(body);

}