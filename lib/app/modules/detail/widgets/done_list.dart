import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todoapp/app/core/utils/extensions.dart';
import 'package:getx_todoapp/app/core/values/colors.dart';
import 'package:getx_todoapp/app/modules/home/controller.dart';

class DoneList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DoneList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCtrl.doneTodos.isNotEmpty
          ? ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 3.0.wp,
                    left: 5.0.wp,
                    right: 5.0.wp,
                    bottom: 2.0.wp,
                  ),
                  child: Text(
                    'Completed (${homeCtrl.doneTodos.length})',
                    style: TextStyle(
                      fontSize: 14.0.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
                ...homeCtrl.doneTodos
                    .map(
                      (e) => Dismissible(
                        key: ObjectKey(e),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) => homeCtrl.deleteDoneTodo(e),
                        background: Container(
                          color: Colors.red.withOpacity(0.8),
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 5.0.wp),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.0.wp,
                            vertical: 1.5.wp,
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child: Icon(
                                  Icons.done,
                                  color: blue,
                                ),
                              ),
                              SizedBox(width: 5.0.wp),
                              Text(
                                e['title'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.0.sp,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList()
              ],
            )
          : Container(),
    );
  }
}
