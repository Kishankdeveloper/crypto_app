import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_app/modules/task/task_controller.dart';
import 'package:crypto_app/network_services/models/tasks_list_model.dart';
import 'package:crypto_app/utills/app_colors.dart';
import 'package:crypto_app/utills/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskScreen extends GetView<TaskController> {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return GetBuilder(
        init: TaskController(),
        builder: (TaskController taskController) {
          return Scaffold(
            body: RefreshIndicator(
              onRefresh: () async {
                controller.getTasks();
              },
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                  children: [
                    SizedBox(height: h * 0.05),
                    SizedBox(
                      height: h * 0.13,
                      child: Image.asset(
                        'assets/images/x-coin.png',
                        width: w * 0.25,
                      ),
                    ),
                    Text(
                      'TASKS',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'madaBold',
                        fontSize: w * 0.07,
                      ),
                    ),
                    Text(
                      'Complete the daily tasks to make more X-Coin',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'madaSemiBold',
                        fontSize: w * 0.04,
                      ),
                    ),
                    SizedBox(height: h * 0.03),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Special Task To Grow',
                        style: TextStyle(
                          fontFamily: 'madaSemiBold',
                          fontSize: w * 0.06,
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.02),
                    Obx(() => controller.loading.value
                        ? const SizedBox.shrink()
                        : (controller.taskList == null || controller.taskList!.isEmpty
                        ? Text(
                      'No Task Available',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.white60,
                        fontFamily: 'madaRegular',
                        fontSize: w * 0.045,
                      ),
                    )
                        : Column(
                      children: List.generate(
                        controller.taskList!.length,
                            (index) {
                          final item = controller.taskList![index];
                          return lisItem(item, h, w);
                        },
                      ),
                    ))),
                    SizedBox(height: h * 0.03),
                  ],

              ),
            ),
          );
        });
  }

  Widget lisItem(TaskListData taskListData, var h, var w) {
    return GestureDetector(
      onTap: () {
        if(taskListData.status == "unclaimed") {
          // start task api call
          controller.linkURL = "${taskListData.taskUrl}";
          controller.taskId = "${taskListData.taskId}";
          controller.update();
          controller.startTask();
        }
        else if(taskListData.status == "completed") {
          controller.taskId = "${taskListData.taskId}";
          controller.taskAmount.value = "${taskListData.xcoinReward}";
          controller.update();
          WidgetUtils.launch(controller.linkURL);
         // controller.claimTask();
        }
        else if(taskListData.status == "claimed") {
          WidgetUtils.showSuccess("Already Claimed");
        }
      },
      child: Container(
        width: w,
        height: h * 0.08,
        padding: EdgeInsets.symmetric(horizontal: w * 0.03),
        margin: EdgeInsets.symmetric(vertical: h * 0.01),
        decoration: BoxDecoration(
            color: AppColors.white100,
            borderRadius: BorderRadius.circular(w * 0.03)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(width: w * 0.07, imageUrl: '${taskListData.taskImage}'),
            SizedBox(width: w * 0.03,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${taskListData.taskName}',
                  style: TextStyle(
                      fontSize: w * 0.045,
                      fontFamily: 'madaSemiBold'
                  ),),
                Text('+ ${taskListData.xcoinReward} X Coin',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.success40,
                      fontSize: w * 0.035,
                      fontFamily: 'madaSemiBold'
                  ),),
              ],
            ),
            const Spacer(),
            GestureDetector(
                onTap: (){
                  if(taskListData.status == "unclaimed") {
                    // start task api call
                    controller.linkURL = "${taskListData.taskUrl}";
                    controller.taskId = "${taskListData.taskId}";
                    controller.update();
                    controller.startTask();
                  }
                  else if(taskListData.status == "completed") {
                    controller.taskId = "${taskListData.taskId}";
                    controller.taskAmount.value = "${taskListData.xcoinReward}";
                    controller.update();
                    controller.claimTask();
                  }
                  else if(taskListData.status == "claimed") {
                    WidgetUtils.showSuccess("Already Claimed");
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.01),
                  decoration: BoxDecoration(
                      color: taskListData.status == "unclaimed" ? AppColors.error60 : taskListData.status == "completed" ? AppColors.success60 : AppColors.success60,
                      borderRadius: BorderRadius.circular(w * 0.04)
                  ),
                  child: Text(taskListData.status == "unclaimed" ? 'START' : taskListData.status == "completed" ? 'Claim' : "Claimed",
                    style: TextStyle(
                        fontFamily: 'madaRegular',
                        fontSize: w * 0.04,
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }

  Widget telegram(var h, var w) {
    return Container(
      width: w,
      height: h * 0.08,
      padding: EdgeInsets.symmetric(horizontal: w * 0.01),
      decoration: BoxDecoration(
          color: AppColors.white100,
          borderRadius: BorderRadius.circular(w * 0.03)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/telegram.png', width: w * 0.07,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Join X Community Telegram',
                style: TextStyle(
                    fontSize: w * 0.045,
                    fontFamily: 'madaSemiBold'
                ),),
              Text('+ 1000 X Coin',
                style: TextStyle(
                    color: AppColors.success40,
                    fontSize: w * 0.035,
                    fontFamily: 'madaSemiBold'
                ),),
            ],
          ),
          GestureDetector(
              onTap: (){},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.01),
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(w * 0.04)
                ),
                child: Text('START',
                  style: TextStyle(
                      fontFamily: 'madaRegular',
                      fontSize: w * 0.04
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
  
  Widget youtube(var h, var w) {
    return Container(
      width: w,
      height: h * 0.08,
      padding: EdgeInsets.symmetric(horizontal: w * 0.01),
      decoration: BoxDecoration(
          color: AppColors.white100,
          borderRadius: BorderRadius.circular(w * 0.03)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/youtube.png', width: w * 0.07,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Subscribe X Youtube Channel',
                style: TextStyle(
                    fontSize: w * 0.045,
                    fontFamily: 'madaSemiBold'
                ),),
              Text('+ 2000 X Coin',
                style: TextStyle(
                    color: AppColors.success40,
                    fontSize: w * 0.035,
                    fontFamily: 'madaSemiBold'
                ),),
            ],
          ),
          GestureDetector(
              onTap: (){},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.01),
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(w * 0.04)
                ),
                child: Text('START',
                  style: TextStyle(
                      fontFamily: 'madaRegular',
                      fontSize: w * 0.04
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
  
  Widget instagram(var h, var w) {
    return Container(
      width: w,
      height: h * 0.08,
      padding: EdgeInsets.symmetric(horizontal: w * 0.01),
      decoration: BoxDecoration(
          color: AppColors.white100,
          borderRadius: BorderRadius.circular(w * 0.03)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/instagram.png', width: w * 0.07,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Follow X on Instagram               ',
                style: TextStyle(
                    fontSize: w * 0.045,
                    fontFamily: 'madaSemiBold'
                ),),
              Text('+ 2000 X Coin',
                style: TextStyle(
                    color: AppColors.success40,
                    fontSize: w * 0.035,
                    fontFamily: 'madaSemiBold'
                ),),
            ],
          ),
          GestureDetector(
              onTap: (){},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.01),
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(w * 0.04)
                ),
                child: Text('START',
                  style: TextStyle(
                      fontFamily: 'madaRegular',
                      fontSize: w * 0.04
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }

  Widget facebook(var h, var w) {
    return Container(
      width: w,
      height: h * 0.08,
      padding: EdgeInsets.symmetric(horizontal: w * 0.01),
      decoration: BoxDecoration(
          color: AppColors.white100,
          borderRadius: BorderRadius.circular(w * 0.03)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/facebook.png', width: w * 0.07,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Join X Page on Facebook           ',
                style: TextStyle(
                    fontSize: w * 0.045,
                    fontFamily: 'madaSemiBold'
                ),),
              Text('+ 2000 X Coin',
                style: TextStyle(
                    color: AppColors.success40,
                    fontSize: w * 0.035,
                    fontFamily: 'madaSemiBold'
                ),),
            ],
          ),
          GestureDetector(
              onTap: (){},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.01),
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(w * 0.04)
                ),
                child: Text('START',
                  style: TextStyle(
                      fontFamily: 'madaRegular',
                      fontSize: w * 0.04
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
}