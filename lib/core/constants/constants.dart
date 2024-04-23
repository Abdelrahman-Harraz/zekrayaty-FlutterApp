//  ------------------------------- Enumerations -----------------------------

enum InputType { signin, signup, forgetPassword, updateProfile }

enum BasicFormType { signup, signin, phoneForm, codeForm, passwordForm }

enum SharedPrefKey {
  email,
  apiToken,
  phone,
  password,
  age,
  state,
  fname,
  lname,
}

enum AppStatus { loggedIn, loggedOut, loading, profileNotFilled }

enum RequestStatus { initial, loading, success, failure }

enum SizeType { big, small }

//  ------------------------------- Page Padding ------------------------------

// Constants for borderRadius, paddingAll, side, side1, and homePadding
const double borderRadius = 15;
const double paddingAll = 10;
const double side = 20;
const double side1 = 40;
const double homePadding = 10;

//  ------------------------------- Element Spacing & Sizing ------------------

// Constants for space0, space0_5, space1, space2, space3, height1, height2, height3, height4, height5, height6, round, and round2
const double space0 = 5;
const double space0_5 = 10;
const double space1 = 15;
const double space2 = 20;
const double space3 = 30;

const double height1 = 50;
const double height2 = 65;
const double height3 = 75;
const double height4 = 115;
const double height5 = 130;
const double height6 = 160;

const double round = 15;
const double round2 = 25;
