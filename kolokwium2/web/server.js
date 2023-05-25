const express = require("express");
const mongoose = require("mongoose");
const bodyParser = require("body-parser");
const fs = require('fs')
// const dotenv = require("dotenv");

const Product = require("./productModel");

// dotenv.config({ path: "./config.env" });

const MONGO_URI = "mongodb://db:27017/stepik";

mongoose.set("strictQuery", false);

// process.env.MONGODB_URI

mongoose
  .connect(MONGO_URI, {
    useNewUrlParser: true,
  })
  .then(async (con) => {
    console.log("DB connection successful!");
    await Product.collection.drop();
    const data = JSON.parse(fs.readFileSync('./data.json', 'utf-8')).data;
    console.log(data);
    await Product.create(data);
  });

const app = express();

app.use(express.static("public"));
app.use(bodyParser.json());

app.get("/products", async (req, res) => {
  const result = await Product.find();

  res.status(200).json({
    status: "success",
    data: {
      products: result,
    },
  });
});

app.delete("/products/:id", async (req, res) => {
  const id = req.params.id;

  const task = await Product.findByIdAndDelete(id);

  if (!task) {
    return res.status(404).json({
      status: "fail",
      message: "No task found with that ID",
    });
  }

  res.status(204).json({status: "success"});

});


app.listen(3000, () => {
  console.log("Listening on port 3000!");
});