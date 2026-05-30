require('dotenv').config();
const express = require('express');
const mysql = require('mysql2/promise');

const app = express();
const PORT = 3000;

app.get('/health', (req, res) => {
  res.json({
    status: 'ok',
    team: 'TeamLastTime',
    project: 'Open Standard'
  });
});

app.get('/db-test', async (req, res) => {
  try {
    const conn = await mysql.createConnection({
      host: process.env.RDS_HOST,
      user: process.env.RDS_USER,
      password: process.env.RDS_PASS,
      database: process.env.RDS_DB
    });
    const [rows] = await conn.execute('SELECT NOW() as time');
    await conn.end();
    res.json({
      status: 'connected',
      db_time: rows[0].time
    });
  } catch (err) {
    res.status(500).json({
      status: 'error',
      message: err.message
    });
  }
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});