const express = require("express");
const dotenv = require("dotenv");
const cors = require("cors");
const { mongoose } = require("mongoose");
const { Product } = require("./src/Models/Products");
const sampleProducts = require("./src/Data/sampleProducts");

const app = express();
app.use(express.json());
app.use(cors());
dotenv.config();
const PORT = process.env.PORT;

async function start() {
  try {
    await mongoose.connect(process.env.MONGO_URI);
    console.log("Connected to database!");
    await Product.collection.drop();
    await Product.insertMany(sampleProducts);
    app.listen(PORT);
    console.log(PORT);
  } catch (error) {
    console.log(error);
  }
}

app.use("/products", require("./src/Routes/ProductRoutes"));

app.use("/report", require("./src/Routes/ReportRouter"));

start();
