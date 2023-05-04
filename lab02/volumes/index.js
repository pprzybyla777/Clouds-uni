const express = require('express');
const app = express();

app.get('/', (req, res) => {
  const currentTime = new Date();
  res.json({ time: currentTime });
  console.log("new get req");
  console.log("lubie placki");
});

app.listen(3000, () => {
  console.log('Aplikacja jest dostępna na porcie 3000!');
});