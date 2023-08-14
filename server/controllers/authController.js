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

module.exports = { addStudent, authenticateStudent, updateStudent };
