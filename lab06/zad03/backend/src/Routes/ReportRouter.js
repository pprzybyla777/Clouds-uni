const express = require("express");
const router = express.Router();
const reportController = require("../Controllers/reportController")


router.route('/')
  .get(reportController.getReport)

module.exports = router;