// api/chat.js
export default async function handler(req, res) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Only POST requests allowed' });
  }

  const userMessage = req.body.message;

  const groqRes = await fetch('https://api.groq.com/openai/v1/chat/completions', {
    method: 'POST',
    headers: {
      'Authorization': `Bearer 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`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      model: 'llama3-8b-8192',
      messages: [{ role: 'user', content: userMessage }],
    }),
  });

  const data = await groqRes.json();
  const reply = data.choices?.[0]?.message?.content || "Sorry, no reply.";

  res.status(200).json({ reply });
}
