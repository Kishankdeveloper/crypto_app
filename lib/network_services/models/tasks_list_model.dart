class TasksListModel {
  bool? status;
  String? message;
  List<TaskListData>? data;

  TasksListModel({this.status, this.message, this.data});

  TasksListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TaskListData>[];
      json['data'].forEach((v) {
        data!.add(TaskListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaskListData {
  int? taskId;
  String? taskName;
  String? taskUrl;
  String? taskImage;
  String? xcoinReward;
  String? status;

  TaskListData({this.taskId, this.taskName, this.taskUrl, this.xcoinReward, this.status});

  TaskListData.fromJson(Map<String, dynamic> json) {
    taskId = json['task_id'];
    taskName = json['task_name'];
    taskUrl = json['task_url'];
    taskImage = json['task_image'];
    xcoinReward = json['xcoin_reward'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['task_id'] = taskId;
    data['task_name'] = taskName;
    data['task_url'] = taskUrl;
    data['task_image'] = taskImage;
    data['xcoin_reward'] = xcoinReward;
    data['status'] = status;
    return data;
  }
}
