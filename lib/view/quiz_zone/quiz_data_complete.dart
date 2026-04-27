final Map<String, dynamic> quizDataComplete = {
  "music_pop_culture_quiz": {
    "title": "Music & Pop Culture Quiz 🎵",
    "description": "Test your knowledge about music and pop culture",
    "type": "mcq",
    "color": "0xFF6366F1",
    "questions": [
      {
        "question":
            "Taylor Swift started her music career mainly in which genre?",
        "options": ["Rock", "Pop", "Country", "Jazz"],
        "answer": "Country",
      },
      {
        "question":
            "Which Taylor Swift album is known for storytelling songs like 'Love Story'?",
        "options": ["Reputation", "Fearless", "1989", "Midnights"],
        "answer": "Fearless",
      },
      {
        "question": "What does K-Pop stand for?",
        "options": [
          "Kids Pop",
          "Korean Popular Music",
          "Karaoke Pop",
          "Kingdom Pop",
        ],
        "answer": "Korean Popular Music",
      },
      {
        "question": "Which country did K-Pop originate from?",
        "options": ["Japan", "China", "South Korea", "Thailand"],
        "answer": "South Korea",
      },
      {
        "question": "BTS fans are called?",
        "options": ["Stars", "Army", "Beats", "Lights"],
        "answer": "Army",
      },
      {
        "question": "BLACKPINK has how many members?",
        "options": ["3", "4", "5", "7"],
        "answer": "4",
      },
      {
        "question":
            "At what age did Billie Eilish release her breakout hit 'Ocean Eyes'?",
        "options": [
          "13 years old",
          "19 years old",
          "22 years old",
          "25 years old",
        ],
        "answer": "13 years old",
      },
      {
        "question": "Billie Eilish is known for which singing style?",
        "options": [
          "Loud classical music",
          "Soft, whisper-style singing",
          "Opera singing",
          "Folk music",
        ],
        "answer": "Soft, whisper-style singing",
      },
      {
        "question": "Who helps Billie Eilish create most of her music?",
        "options": [
          "Her teacher",
          "Her brother Finneas",
          "A big band",
          "Her fans",
        ],
        "answer": "Her brother Finneas",
      },
      {
        "question":
            "What animal is often linked with Taylor Swift's fan culture?",
        "options": ["Lion", "Snake", "Horse", "Panda"],
        "answer": "Snake",
      },
    ],
  },
  "gaming_addiction_quiz": {
    "title": "Gaming Addiction Assessment 🎮",
    "description": "Assess your gaming habits and balance",
    "type": "assessment",
    "color": "0xFFFF7043",
    "questions": [
      {
        "question": "When I'm not playing games...",
        "options": [
          {"text": "Hardly think about them", "points": 1},
          {"text": "Think about them sometimes", "points": 2},
          {"text": "Keep thinking about them all the time", "points": 3},
        ],
      },
      {
        "question": "I play games for...",
        "options": [
          {"text": "A short time and stop easily", "points": 1},
          {"text": "Longer than I plan", "points": 2},
          {"text": "So long that I forget other things", "points": 3},
        ],
      },
      {
        "question": "When I lose in a game...",
        "options": [
          {"text": "Just move on", "points": 1},
          {"text": "Feel a bit angry", "points": 2},
          {"text": "Get very angry or upset", "points": 3},
        ],
      },
      {
        "question": "When I have homework or outdoor playtime...",
        "options": [
          {"text": "I finish my work first, then play", "points": 1},
          {
            "text": "I delay my work to play 'just one more round'",
            "points": 2,
          },
          {
            "text": "I skip my homework or playtime because of gaming",
            "points": 3,
          },
        ],
      },
      {
        "question": "I feel happiest when...",
        "options": [
          {"text": "I'm spending time with my friends or family", "points": 1},
          {"text": "I win a game", "points": 2},
          {"text": "I'm alone and playing games for hours", "points": 3},
        ],
      },
      {
        "question": "When friends talk about games...",
        "options": [
          {"text": "I listen and join a little", "points": 1},
          {
            "text": "I get excited and can't stop talking about it",
            "points": 2,
          },
          {
            "text": "I only want to talk about games and nothing else",
            "points": 3,
          },
        ],
      },
      {
        "question": "When my parents ask me to stop gaming...",
        "options": [
          {"text": "I stop and move on", "points": 1},
          {"text": "I get annoyed but stop after a while", "points": 2},
          {"text": "I get angry, shout, or secretly play again", "points": 3},
        ],
      },
      {
        "question": "When my parents say 'no more games'...",
        "options": [
          {"text": "I listen and do something else", "points": 1},
          {
            "text": "I sneak a few minutes when they're not looking",
            "points": 2,
          },
          {"text": "I hide and play a lot even when told not to", "points": 3},
        ],
      },
      {
        "question": "When I go a day without gaming...",
        "options": [
          {"text": "I feel fine", "points": 1},
          {"text": "I feel a little bored", "points": 2},
          {"text": "I feel sad, restless, or angry", "points": 3},
        ],
      },
      {
        "question": "I play games for (daily time)...",
        "options": [
          {"text": "A short time each day", "points": 1},
          {"text": "A few hours and sometimes forget the time", "points": 2},
          {"text": "So long that I forget to eat or sleep", "points": 3},
        ],
      },
    ],
    "score_ranges": [
      {
        "min": 10,
        "max": 15,
        "result":
            "✅ Healthy Gaming Habits\n\nGreat balance! You manage your gaming time well.",
        "color": "green",
      },
      {
        "min": 16,
        "max": 22,
        "result":
            "⚠️ Needs Control\n\nYou may be gaming too much. Try setting time limits.",
        "color": "orange",
      },
      {
        "min": 23,
        "max": 30,
        "result":
            "🔴 High Risk\n\nGaming is affecting your daily life significantly.",
        "color": "red",
      },
    ],
  },
  "mobile_addiction_quiz": {
    "title": "Mobile Phone Addiction Assessment 📱",
    "description": "Evaluate your mobile phone habits",
    "type": "assessment",
    "color": "0xFF26A69A",
    "questions": [
      {
        "question": "When I wake up...",
        "options": [
          {"text": "Brush teeth/get ready", "points": 1},
          {"text": "Say morning to family", "points": 2},
          {"text": "Check phone/videos", "points": 3},
        ],
      },
      {
        "question": "If someone takes my phone...",
        "options": [
          {"text": "Give it easily", "points": 1},
          {"text": "Feel a little upset", "points": 2},
          {"text": "Get angry or shout", "points": 3},
        ],
      },
      {
        "question": "If phone has no charge...",
        "options": [
          {"text": "Don't mind, play/read", "points": 1},
          {"text": "Feel bored for a while", "points": 2},
          {"text": "Feel restless", "points": 3},
        ],
      },
      {
        "question": "When I'm eating...",
        "options": [
          {"text": "Keep phone away", "points": 1},
          {"text": "Look at it sometimes", "points": 2},
          {"text": "Always watch videos", "points": 3},
        ],
      },
      {
        "question": "Before sleeping...",
        "options": [
          {"text": "Keep phone away", "points": 1},
          {"text": "Watch a few videos", "points": 2},
          {"text": "Use until I fall asleep", "points": 3},
        ],
      },
      {
        "question": "If parents ask me to stop...",
        "options": [
          {"text": "Stop without problem", "points": 1},
          {"text": "Stop but feel unhappy", "points": 2},
          {"text": "Argue or refuse", "points": 3},
        ],
      },
      {
        "question": "When feeling sad/lonely...",
        "options": [
          {"text": "Talk/play outside", "points": 1},
          {"text": "Sometimes use phone", "points": 2},
          {"text": "Always use phone", "points": 3},
        ],
      },
      {
        "question": "During study/homework...",
        "options": [
          {"text": "Keep phone away", "points": 1},
          {"text": "Look once in a while", "points": 2},
          {"text": "Check many times", "points": 3},
        ],
      },
      {
        "question": "No notifications day...",
        "options": [
          {"text": "Don't care much", "points": 1},
          {"text": "Wonder why", "points": 2},
          {"text": "Feel sad/forgotten", "points": 3},
        ],
      },
      {
        "question": "I keep my phone...",
        "options": [
          {"text": "In another room", "points": 1},
          {"text": "Close by just in case", "points": 2},
          {"text": "Always with me", "points": 3},
        ],
      },
    ],
    "score_ranges": [
      {
        "min": 10,
        "max": 15,
        "result":
            "✅ Healthy Phone Habits\n\nGreat balance! You use your phone responsibly.",
        "color": "green",
      },
      {
        "min": 16,
        "max": 22,
        "result": "⚠️ Needs Attention\n\nYou may be using the phone too much.",
        "color": "orange",
      },
      {
        "min": 23,
        "max": 30,
        "result": "🔴 High Risk\n\nPhone usage is affecting your daily life.",
        "color": "red",
      },
    ],
  },
};
