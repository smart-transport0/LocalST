class Validators {
  String validateName(String name) {
    name = name.trim();
    if (name.isEmpty) return ' cannot be empty\n';
    if (name.length > 15) return ' cannot be longer than 15 characters\n';
    const pattern = r'^[a-zA-Z]+$';
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(name)) return ' is invalid\n';
    return '';
  }

  String checkNotEmpty(String data) {
    data = data.trim();
    if (data.isEmpty) return ' cannot be empty\n';
    return '';
  }

  String validateRollNumber(String rollno) {
    rollno = rollno.trim();
    const pattern = r'^[0-9][0-9][A-Za-z0-9]*$';
    if (rollno.isEmpty) {
      return 'Roll Number cannot be empty';
    }
    if (!RegExp(pattern).hasMatch(rollno)) return 'Roll Number is invalid\n';
    return '';
  }

  String validatePassword(String password) {
    if (password.length >= 8) {
      const pattern =
          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
      if (!RegExp(pattern).hasMatch(password)) {
        return 'Password is invalid\n';
      } else {
        return '';
      }
    } else {
      return 'Password is too short\n';
    }
  }

  String validateEmail(String email) {
    if (email.isEmpty) {
      return 'Organization email cannot be empty\n';
    }
    const pattern1 = r'^[a-zA-Z0-9.]+@sot.pdpu.ac.in$';
    const pattern2 = r'^[a-zA-Z0-9.]+@sls.pdpu.ac.in$';
    const pattern3 = r'^[a-zA-Z0-9.]+@spm.pdpu.ac.in$';
    const pattern4 = r'^[a-zA-Z0-9.]+@spt.pdpu.ac.in$';
    //Might need to add more patterns
    if (!RegExp(pattern1).hasMatch(email) &&
        !RegExp(pattern2).hasMatch(email) &&
        !RegExp(pattern3).hasMatch(email) &&
        !RegExp(pattern4).hasMatch(email)) {
      return 'Invalid Organization Email\n';
    } else {
      return '';
    }
  }

  String validatePhoneNumber(String phone) {
    if (phone.isEmpty) return 'Phone Number cannot be empty\n';
    if (phone.length < 10) return 'Phone Number too short\n';
    const pattern = r'^[6-9]\d{9}$';
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(phone)) return 'Invalid Phone Number\n';
    return '';
  }

  bool validateNumberPlate(String numberPlate) {
    int minLength = 6, maxLength = 14;
    const pattern = r'^[A-Z][A-Z]( ?)\d\d( ?)[A-Z]{0,3}(\d{1,4})$';
    final regExp = RegExp(pattern);
    if (numberPlate.length < minLength ||
        numberPlate.length > maxLength ||
        !regExp.hasMatch(numberPlate)) return false;
    return true;
  }
}
