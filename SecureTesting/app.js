// app.js
const express = require('express');
const mysql = require('mysql');
const { exec } = require('child_process');
const _ = require('lodash');
const serialize = require('node-serialize');

const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

/*
 * 1) SQL Injection (SAST)
 * Using string concatenation to build queries from user input.
 * Static analysis should flag concatenation-based queries.
 */
const db = mysql.createConnection({
  host: '127.0.0.1', user: 'root', password: '', database: 'demo'
});
//db.connect();

/* vulnerable route: builds query using unsanitized input */
app.get('/user', (req, res) => {
  const id = req.query.id; // attacker-controlled
  // BAD: direct interpolation -> SQL injection risk
  console.log(id)
  
  //res.send(id)
  const q = "SELECT * FROM users WHERE id = '" + id + "'";
  db.query(q, (err, rows) => {
    if (err) return res.status(500).send('db error');
    res.json(rows);
  });
});

/*
 * 2) Command Injection / Unsafe child_process usage (SAST)
 * Passing raw user input into shell execution.
 */
app.post('/run', (req, res) => {
  const cmdArg = req.body.cmd; // attacker-controlled
  // BAD: exec spawns a shell; passing user input directly is dangerous
  exec(`ls ${cmdArg}`, (err, stdout, stderr) => {

    console.log(stdout);
    if (err) return res.status(500).send(err);
    res.send(stdout);
  });
});

/*
 * 3) Insecure Deserialization (SAST + demonstrates vulnerable dependency usage)
 * Using node-serialize.unserialize() on untrusted input is dangerous.
 * The node-serialize package version in package.json is intentionally old and vulnerable.
 */
app.post('/deserialize', (req, res) => {
  const s = req.body.payload; // attacker-controlled
  try {
    // BAD: deserializing untrusted input
    const obj = JSON.stringify(s);
    res.json({ ok: true, obj });
  } catch (e) {
    res.status(400).send(e);
  }
});

/*
 * 4) Prototype pollution pattern (SAST + SCA)
 * Using lodash in a way where untrusted keys might be merged into objects.
 * Even if lodash itself weren't vulnerable, unsafe merges with untrusted keys are risky.
 */
app.post('/merge', (req, res) => {
  const userObj = req.body.data; // attacker-controlled
  const config = { safe: true, options: {} };
  // BAD: merging untrusted object into internal config
  _.merge(config, userObj);
  res.json(config);
});

/*
 * 5) Weak hashing usage (SAST)
 * Using MD5 (or other fast hash) for purposes that require cryptographic hashing.
 * This is a coding smell that SAST tools highlight (use bcrypt/argon2 for passwords).
 */
const crypto = require('crypto');
app.post('/weak-hash', (req, res) => {
  const pw = req.body.pw || '';
  // BAD: fast/weak hash for passwords
  const hash = crypto.createHash('md5').update(pw).digest('hex');
  res.json({ hash });
});

app.listen(3000, () => console.log('demo app running on :3000'));
