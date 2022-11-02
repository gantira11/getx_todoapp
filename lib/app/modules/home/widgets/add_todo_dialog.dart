import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_todoapp/app/core/utils/extensions.dart';
import 'package:getx_todoapp/app/modules/home/controller.dart';

class AddTodoDialog extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  AddTodoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Form(
          key: homeCtrl.formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(3.0.wp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                        homeCtrl.titleCtrl.clear();
                        homeCtrl.changeTask(null);
                      },
                      icon: const Icon(Icons.close),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                          Colors.transparent,
                        ),
                      ),
                      onPressed: () {
                        if (homeCtrl.formKey.currentState!.validate()) {
                          if (homeCtrl.task.value == null) {
                            EasyLoading.showError('Please Select task Type');
                          } else {
                            var success = homeCtrl.updateTask(
                              homeCtrl.task.value!,
                              homeCtrl.titleCtrl.text,
                            );
                            if (success) {
                              EasyLoading.showSuccess('Todo item add success');
                              Get.back();
                              homeCtrl.changeTask(null);
                            } else {
                              EasyLoading.showError('Todo item already exist!');
                            }
                            homeCtrl.titleCtrl.clear();
                          }
                        }
                      },
                      child: Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 13.0.sp,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                child: Text(
                  'Add New Task',
                  style: TextStyle(
                    fontSize: 18.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 5.0.wp, vertical: 4.0.wp),
                child: TextFormField(
                  controller: homeCtrl.titleCtrl,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                    label: Text(
                      'Title',
                      style: TextStyle(
                        fontSize: 14.0.sp,
                        color: Colors.grey[400],
                      ),
                    ),
                    isDense: true,
                  ),
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Field is Required';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 2.0.wp,
                  left: 5.0.wp,
                  right: 5.0.wp,
                  bottom: 2.0.wp,
                ),
                child: Text(
                  'Task type',
                  style: TextStyle(
                    fontSize: 14.0.sp,
                    color: Colors.grey,
                  ),
                ),
              ),
              ...homeCtrl.tasks
                  .map(
                    (e) => Obx(
                      () => InkWell(
                        onTap: () => homeCtrl.changeTask(e),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 3.0.wp,
                            horizontal: 5.0.wp,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    IconData(e.icon,
                                        fontFamily: 'MaterialIcons'),
                                    color: HexColor.fromHex(e.color),
                                  ),
                                  SizedBox(width: 2.5.wp),
                                  Text(
                                    e.title,
                                    style: TextStyle(
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              if (homeCtrl.task.value == e)
                                const Icon(
                                  Icons.check,
                                  color: Colors.blue,
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList()
            ],
          ),
        ),
      ),
    );
  }
}
