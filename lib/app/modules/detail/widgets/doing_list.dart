import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:getx_todoapp/app/core/utils/extensions.dart';
import 'package:getx_todoapp/app/modules/home/controller.dart';

class DoingList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DoingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCtrl.doingTodos.isEmpty && homeCtrl.doneTodos.isEmpty
          ? Column(
              children: [
                SvgPicture.asset(
                  'assets/images/todo.svg',
                  fit: BoxFit.cover,
                  width: 65.0.wp,
                ),
                SizedBox(height: 8.0.wp),
                Text(
                  'Add Tasks',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0.sp,
                  ),
                )
              ],
            )
          : ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                ...homeCtrl.doingTodos
                    .map(
                      (element) => Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 2.0.wp,
                          horizontal: 8.0.wp,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                fillColor: MaterialStateProperty.resolveWith(
                                  (states) => Colors.grey,
                                ),
                                value: element['done'],
                                onChanged: (value) {
                                  homeCtrl.doneTodo(element['title']);
                                },
                              ),
                            ),
                            SizedBox(width: 3.0.wp),
                            Text(
                              element['title'],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12.0.sp),
                            )
                          ],
                        ),
                      ),
                    )
                    .toList(),
                if (homeCtrl.doingTodos.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0.wp,
                      vertical: 2.0.wp,
                    ),
                    child: const Divider(
                      thickness: 0.5,
                      color: Colors.black54,
                    ),
                  )
              ],
            ),
    );
  }
}
