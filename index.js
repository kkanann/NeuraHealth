const express = require('express');
const axios = require('axios');
const cors = require('cors');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

const GROQ_API_KEY = process.env.GROQ_API_KEY;

app.get('/', (req, res) => {
  res.send('NeuraHealth API is running 🚀');
});

app.post('/chat', async (req, res) => {
  const { message } = req.body;

  try {
    const response = await axios.post(
      'https://api.cohere.ai/v1/generate',
      {
        model: 'command',
        prompt: `User: ${message}\nAI:`,
        max_tokens: 100,
        temperature: 0.7,
      },
      {
        headers: {
          Authorization: `Bearer ${GROQ_API_KEY}`,
          'Content-Type': 'application/json',
        },
      }
    );

    const reply = response.data.generations[0].text.trim();
    res.json({ reply });
  } catch (error) {
    console.error('Error contacting Cohere:', error.message);
    res.status(500).json({ error: 'Failed to connect to Cohere' });
  }
});

app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});
