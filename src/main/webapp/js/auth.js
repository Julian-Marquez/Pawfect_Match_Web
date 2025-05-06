// JavaScript Password Validation
function auth(password, cpassword) { 
  //  if (password !== cpassword) {
       // alert("Passwords must match");
      //  return false; // Return false to indicate validation failed
    //}

    if (password.length <= 7) {
        alert("Password must be at least 8 characters long");
        return false; // Return false to indicate validation failed
    }

    const specialChars = /[@!#$%^&*]/; // Regex to check for special characters
    if (!specialChars.test(password)) {
        alert("Password must have at least one special character");
        return false; // Return false to indicate validation failed
    }

    return true; // If all checks pass
}



