const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const Student = require("../models/student");

const addStudent = async (req, res) => {
  try {
    const {
      firstName,
      lastName,
      email,
      username,
      password,
      specialization,
      year,
      semester,
      group,
    } = req.body;

    const hashedPassword = await bcrypt.hash(password, 10);

    let newStudent = new Student({
      firstName,
      lastName,
      email,
      username,
      password: hashedPassword,
      specialization,
      year,
      semester,
      group,
    });

    newStudent = await newStudent.save();
    res.json(newStudent);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};


const authenticateStudent = async (req, res) => {
  try {
    const { username, password } = req.body;  

    const student = await Student.findOne({ username });  
    if (!student) {
      return res.status(400).json({ msg: "Student with this username does not exist" }); 
    }

    const isMatch = await bcrypt.compare(password, student.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect Password" });
    }

    const token = jwt.sign({ id: student._id }, "passwordKey");
    res.status(200).json({ token, ...student._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};

const updateStudent = async (req, res) => {
  try {
    const { studentId } = req.params; 

    const updatedFields = {
      firstName: req.body.firstName,
      lastName: req.body.lastName,
      email: req.body.email,
      specialization: req.body.specialization,
      year: req.body.year,
      semester: req.body.semester,
      group: req.body.group,
    };

    // Remove undefined values
    Object.keys(updatedFields).forEach(key => updatedFields[key] === undefined && delete updatedFields[key]);

    const updatedStudent = await Student.findByIdAndUpdate(studentId, { $set: updatedFields }, { new: true });

    if (!updatedStudent) {
      return res.status(404).json({ msg: "Student not found" });
    }

    res.json(updatedStudent);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};


const checkOldPassword = async (req, res) => {
  const { studentId, password } = req.body; // Assuming the student's unique ID and password are passed in the body.

  try {
      const student = await Student.findOne(studentId);
      if (!student) {
          return res.status(404).send({ message: 'Student not found' });
      }

      // Using bcrypt to compare the plain password with its hashed version.
      bcrypt.compare(password, student.password, (err, isMatch) => {
        if (err) {
            return res.status(500).send({ message: 'Server error during password comparison' });
        }

        if (isMatch) {
            res.send({ isValid: true });
        } else {
            res.send({ isValid: false });
        }
    });
  } catch (err) {
      res.status(500).send({ message: 'Server error' });
  }
};


const updatePassword = async (req, res) => {
  const { studentId, newPassword } = req.body;

  try {
      // Hash the new password using bcrypt
      const hashedPassword = await bcrypt.hash(newPassword, 10); // '10' is the number of salt rounds.

      // Update the password in the database with the hashed version
      const result = await Student.updateOne({ _id: studentId }, { $set: { password: hashedPassword } });
      
      if (result.modifiedCount === 1) {
          res.send({ success: true });
      } else {
          res.status(400).send({ message: 'Failed to update password' });
      }
  } catch (err) {
      res.status(500).send({ message: 'Server error' });
  }
};


const checkEmailInDatabase = async (req, res) => {
  try {
      const { email } = req.body; // Assuming the email is passed in the body.

      const student = await Student.findOne({ email });
      
      if (student) {
          return res.status(200).json({ exists: true });
      } else {
          return res.status(200).json({ exists: false });
      }
  } catch (err) {
      res.status(500).json({ error: err.message });
  }
};

// Add checkEmailInDatabase to your exports
module.exports = { addStudent, authenticateStudent, updateStudent, checkOldPassword, updatePassword, checkEmailInDatabase };


