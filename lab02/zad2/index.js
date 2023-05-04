const express = require('express');
const app = express();

app.get('/', (req, res) => {
  const currentTime = new Date();
  res.json({ time: currentTime });
});

app.listen(8080, () => {
  console.log('Aplikacja jest dostępna na porcie 8080!');
});