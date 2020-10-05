class LocalShare {
  //记录是否已经登录
  static final String IS_LOGIN = "isLogin";
  static bool loginFlag = false;

  //记录base64码的照片
  static final String IMAGE_BASE_64 = "image_base_64";

  static final String STU_INFO = "stu_info";

  //记录姓名
  static final String STU_NAME = "stu_name";

  //记录所在学院
  static final String STU_ACADEMY = "stu_academy";

  //记录所在专业
  static final String STU_MAJOR = "stu_major";

  //记录学号
  static final String STU_ID = "stu_id";

  //记录密码
  static final String STU_PASSWD = "stu_passwd";

  //记录体育课密码
  static final String PE_PASSWD = "pe_passwd";

  //记录课表的背景图片的base64
  static final String BG_COURSE_64 = "bg_course_64";

  //记录是否导入课程表,true表示已经导入过课表，false表示未导入课表，默认为false
  static final String IS_OPEN_KB = "is_open_kb";

  //保存的课表
  static final String HANDLED_KB = "handled_kb";

  //课表备注
  static final String CLASS_MORE = "class_more";

  //记录学期信息
  static final String SEMESTER = "semester";

  // 记录校区
  static final String SCHOOLAREA = "schoolarea";

  //记录当前周次
  static final String SERVER_WEEK = "server_week";

  //记录该学生的所有学年
  static final String ALL_YEAR = "all_year";

  //判断是否已经有校历信息，默认false表示没有导入校历信息
  static final String IS_HAVE_XIAOLI = "is_have_xiaoli";

  // 头像
  static String AVATAR = 'avatar';

  // 课表背景
  static String BACKGROUND = 'background';

  // 是否开启启动时自动检查更新
  static String AUTO_UPDATE = "auto_update";

  // 本周未上课程是否可见
  static String CLASS_VISIBLE = "class_visible";

  // 设置语言
  static String LANGUAGE = "language";

  // 提前周次
  static String WEEK_ADVANCE = "week_advance";
}
