import 'package:get/get.dart';
import 'package:ysfintech_admin/model/project.dart';
import 'package:ysfintech_admin/utils/firebase.dart';

class ProjectController extends GetxController {
  /// to list the uploaded projects
  Rx<List<Project>> projectList = Rx<List<Project>>([]);
  Rx<Map<int, String>> docIDMap = Rx<Map<int, String>>({});

  /// getter
  List<Project> get projects => projectList.value;
  Map<int, String> get docIDs => docIDMap.value;

  /// LIFE-CYCLE
  @override
  void onInit() {
    /// load projects with using stream
    final fetched = FireStoreDB.getProjectStream();
    projectList.bindStream(fetched.map((event) => event.first as List<Project>).cast());
    docIDMap.bindStream(
        fetched.map((event) => event.last as Map<int, String>).cast());
    super.onInit();
  }

  /// methods

}
