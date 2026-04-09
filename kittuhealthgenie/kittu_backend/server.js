const express = require('express');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

let patients = [];

app.post('/patients', (req, res) => {
    const patient = req.body;
    patients.push(patient);
    res.json({ message: 'Patient added', data: patient });
});

app.get('/patients', (req, res) => {
    res.json(patients);
});

app.listen(3000, () => {
    console.log('Server running on http://localhost:3000');
});