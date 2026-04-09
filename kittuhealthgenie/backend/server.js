import express from "express";
import cors from "cors";
import fetch from "node-fetch";
import dotenv from "dotenv";

dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());

// 🔐 Use ENV instead of hardcoding
const OPENAI_API_KEY = process.env.OPENAI_API_KEY;

// 🧠 AI Diagnose API
app.post("/diagnose", async (req, res) => {
  const { symptoms } = req.body;

  try {
    const response = await fetch("https://api.openai.com/v1/chat/completions", {
      method: "POST",
      headers: {
        "Authorization": `Bearer ${OPENAI_API_KEY}`,
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        model: "gpt-4o-mini",
        messages: [
          {
            role: "system",
            content: `
You are a professional medical AI.

Give structured response:
1. Possible diseases
2. Symptoms
3. Causes
4. Solutions
5. Warning signs

Keep it clear and medically useful.
`
          },
          {
            role: "user",
            content: symptoms
          }
        ]
      })
    });

    const data = await response.json();

    res.json({
      result: data.choices?.[0]?.message?.content || "No response"
    });

  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "AI error" });
  }
});

// 🔥 Test Routes
app.get("/", (req, res) => {
  res.send("🚀 Kittu Health Genie Backend Running");
});

app.get("/api/health", (req, res) => {
  res.json({ status: "OK", message: "Health API working 🔥" });
});

// 🚀 Server Start
const PORT = 5000;
app.listen(PORT, () => {
  console.log(`🔥 Server running on http://localhost:${PORT}`);
});