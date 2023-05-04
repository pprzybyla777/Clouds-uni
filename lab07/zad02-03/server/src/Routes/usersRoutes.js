const express = require("express");
const router = express.Router();

const usersController = require("../Controllers/usersController")

router.route('/')
  .get(usersController.getUsers)

module.exports = router;