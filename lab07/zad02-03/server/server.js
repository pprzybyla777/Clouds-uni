const express = require("express"); 
const cors = require("cors"); 
const { mongoose } = require("mongoose");

const app = express();
app.use(express.json());
app.use(cors());

const PORT = 3003;
// const MONGO_URI = "mongodb://localhost:27019/stepik"
// const MONGO_URI = "mongodb://db:27019/stepik" nie działa bo 27019 to port z localhost
const MONGO_URI = "mongodb://db:27017/stepik" 

async function start() {
  try {
    await mongoose.connect(MONGO_URI);
    console.log("Connected to database!");
    app.listen(PORT);
    console.log(PORT);
  } catch (error) {
    console.log(error);
  }
}

app.use("/users", require("./src/Routes/usersRoutes"));

start();
