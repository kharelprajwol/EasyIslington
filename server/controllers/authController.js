const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const Student = require("../models/student");

const addStudent = async (req, res) => {
  try {
    const {
      firstName,
      lastName,
      email,
      password,
      specialization,
      year,
      semester,
      section,
    } = req.body;

    const existingStudent = await Student.findOne({ email });
    if (existingStudent) {
      return res
        .status(400)
        .json({ msg: "Student with same email already exists" });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    let newStudent = new Student({
      firstName,
      lastName,
      email,
      password: hashedPassword,
      specialization,
      year,
      semester,
      section,
    });

    newStudent = await newStudent.save();
    res.json(newStudent);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};

const authenticateStudent = async (req,res) => {
  try {
    const {email,password} = req.body;
    const student = await Student.findOne({email});
    if(!student) {
      return res.status(400).json({msg: "Student with this email does not exist"});
    }
    const isMatch = await bcrypt.compare(password,student.password)
    if(!isMatch) {
      return res.status(400).json({msg:"Incorrect Password"})
    }

    const token = jwt.sign({id: student._id}, "passwordKey");
    res.json({token, ...student._doc})
  } catch (e) {
    res.status(500).json({error:e.message})
  }
  


}

module.exports = { addStudent, authenticateStudent };
