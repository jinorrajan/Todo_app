import 'package:flutter/material.dart';
import 'package:todo/src/utlis/constant/colors.dart';

// ignore: must_be_immutable
class TodoTile extends StatelessWidget {
  final String taskTitle;
  final String taskContent;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  final Function(BuildContext)? editFunction;
  TodoTile({
    super.key,
    required this.taskTitle,
    required this.taskContent,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
    required this.editFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
      
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: ConstColors.secondaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: ConstColors.mainColor,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  height: 55,
                  width: 260,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        taskTitle,
                        style: TextStyle(
                          fontSize: 20,
                          decoration: taskCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                     const  SizedBox(
                        height: 2,
                      ),
                      Text(
                        taskContent,
                        style: TextStyle(
                          fontSize: 13,
                          decoration: taskCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
             const  Spacer(),
              PopupMenuButton(
                color: ConstColors.secondaryColor,
                onSelected: (value){
                  if(value == 'edit'){
                    editFunction!(context);
                  }else if (value == 'delete'){
                    deleteFunction!(context);
                  }
                },
                itemBuilder: (context)=>[
                 const PopupMenuItem(
                  value: 'edit',
                  child: Text('Edit'),
                ),
              const  PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete'),
                ),
                ])
            ],
          ),
        
      ),
    );
  }
}
