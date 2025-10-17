import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../controllers/attented/attented_controller.dart';
import '/routes/app_route_names.dart';

class CheckinScreen extends StatefulWidget {
  const CheckinScreen({super.key});

  @override
  State<CheckinScreen> createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late AttentedController controller;
  late final dynamic user;

  @override
  void initState() {
    super.initState();
    user = Get.arguments;
    controller = Get.put(AttentedController(), permanent: true);
    controller.setUser(user);
    controller.getAttentedLists(user.id.toString());
  }

  @override
  void dispose() {
    if (Get.isRegistered<AttentedController>()) {
      Get.delete<AttentedController>();
    }
    super.dispose();
  }

  /// Build circular day widget
  Widget _buildDay(DateTime day, Color color, {Color? border}) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: border != null ? Border.all(color: border) : null,
      ),
      alignment: Alignment.center,
      child: Text(
        "${day.day}",
        style: TextStyle(
          color: color == Colors.transparent ? Colors.black87 : Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// Build table row
  TableRow _buildRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            value,
            style: TextStyle(fontSize: 16, color: Colors.grey[800]),
          ),
        ),
      ],
    );
  }

  /// Profile info table
  Widget _buildProfileInfo() {
    final user = controller.userold.value;
    final profileUrl = user?.profile?.profile?.toString();
    final phone = user?.profile?.phone ?? "-";
    return Column(
      children: [
        if (profileUrl != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              user.profile.profile.toString(),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.person, size: 100),
            ),
          )
        else
          const Icon(Icons.person, size: 100),
        const SizedBox(height: 20),
        Table(
          columnWidths: const {0: FlexColumnWidth(2), 1: FlexColumnWidth(3)},
          border: TableBorder.all(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            _buildRow("account".tr, user.username ?? "-"),
            _buildRow(
              "name".tr,
              "${user.first_name ?? ''} ${user.last_name ?? ''}",
            ),
            _buildRow("email_user".tr, user.email ?? "-"),
            _buildRow("phone".tr, phone),
          ],
        ),
      ],
    );
  }

  /// Get is_leave for a given day
  bool getIsLeaveForDay(DateTime day, Map<DateTime, bool> dayStatus) {
    for (var entry in dayStatus.entries) {
      if (isSameDay(entry.key, day)) {
        return entry.value;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${user.first_name ?? ''} ${user.last_name ?? ''}"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.offAllNamed(AppRouteNames.main, arguments: 3);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildProfileInfo(),
            const SizedBox(height: 20),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              DateTime minDate;
              DateTime maxDate;
              late Map<DateTime, bool> dayStatus;
              if (controller.attentlists.isEmpty) {
                minDate = DateTime.now().subtract(const Duration(days: 30));
                maxDate = DateTime.now();
                dayStatus = {};
              } else {
                dayStatus = {
                  for (var d in controller.attentlists)
                    DateTime.parse(d.date.toString()): d.is_leave,
                };

                minDate = dayStatus.keys.reduce(
                  (a, b) => a.isBefore(b) ? a : b,
                );
                maxDate = dayStatus.keys.reduce((a, b) => a.isAfter(b) ? a : b);
              }
              return Expanded(
                child: TableCalendar(
                  focusedDay: _focusedDay,
                  firstDay: DateTime(2020),
                  lastDay: DateTime(2030),
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  calendarFormat: CalendarFormat.month,
                  onDaySelected: (selectedDay, focusedDay) {
                    // if (selectedDay.isAfter(DateTime.now())) return;
                    // if (selectedDay.isBefore(DateTime.now())) return;

                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });

                    // Show dialog for today
                    if (isSameDay(selectedDay, DateTime.now())) {
                      if (dayStatus.isEmpty) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => AlertDialog(
                            title: Text("select_status".tr),
                            content: Text(
                              "${'mark_your_attendance_for'.tr} ${selectedDay.day}-${selectedDay.month}-${selectedDay.year}",
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  controller.addattented(
                                    controller.userold.value.id.toString(),
                                    "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}",
                                    true,
                                  );
                                },
                                child: Text("leave_day".tr),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  controller.addattented(
                                    controller.userold.value.id.toString(),
                                    "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}",
                                    false,
                                  );
                                },
                                child: Text("work_day".tr),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("close".tr),
                              ),
                            ],
                          ),
                        );
                      } else {
                        if (maxDate.toIso8601String().split('T')[0] ==
                            DateTime.now().toIso8601String().split('T')[0]) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => AlertDialog(
                              title: Text("select_status".tr),
                              content: Text("already_attented".tr),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('X ${"close".tr}'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => AlertDialog(
                              title: Text("select_status".tr),
                              content: Text(
                                "${'mark_your_attendance_for'.tr} ${selectedDay.day}-${selectedDay.month}-${selectedDay.year}",
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    controller.addattented(
                                      controller.userold.value.id.toString(),
                                      "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}",
                                      true,
                                    );
                                  },
                                  child: Text("leave_day".tr),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    controller.addattented(
                                      controller.userold.value.id.toString(),
                                      "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}",
                                      false,
                                    );
                                  },
                                  child: Text("work_day".tr),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("close".tr),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    }
                  },
                  headerVisible: true,
                  calendarStyle: const CalendarStyle(
                    defaultDecoration: BoxDecoration(shape: BoxShape.circle),
                    todayDecoration: BoxDecoration(
                      color: Colors.teal,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, day, focusedDay) {
                      // Determine color
                      Color color = Colors.transparent;

                      if (day.isAfter(maxDate)) {
                        color = Colors.grey.shade400;
                      } else if (day.isBefore(minDate)) {
                        color = Colors.redAccent;
                      } else {
                        color = getIsLeaveForDay(day, dayStatus)
                            ? Colors.redAccent
                            : Colors.green;
                      }

                      return _buildDay(day, color);
                    },
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
