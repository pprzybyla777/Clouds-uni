const asyncHandler = require("express-async-handler");
const { User } = require("../Models/Users");

const getUsers = asyncHandler(async (req, res) => {

  const users = await User.find({}, {_id: 0, "__v": 0});

  if (users.length === 0) {
    res.status(404).json({ message: "No users found" });
  }
  
  res.status(200).json(users);

});



module.exports = {
  getUsers,
};