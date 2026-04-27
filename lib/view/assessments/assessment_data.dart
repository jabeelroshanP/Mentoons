final Map<String, dynamic> eatHealthyAssessmentData = {
  "eat_healthy": {
    "title": "Eat Healthy Assessment",
    "subtitle": "Discover Your Eating Habits",
    "description":
        "10 Quick Questions: Easy, multiple-choice format.\nGain Valuable Insights: Personal nutrition tips and well-being advice.",
    "icon": "🍎",
    "price": "Free",
    "isFree": true,
    "questions": [
      {
        "id": 1,
        "question": "When I feel lazy",
        "image": "assets/assessment/EAT_HEALTHY_1.jpg",
        "options": [
          {
            "text": "I'll make a quick salad",
            "trait": "HealthyEater",
            "score": 3,
            "imagePosition": "left",
          },
          {
            "text": "I'll order fried chicken",
            "trait": "UnhealthyChoices",
            "score": 1,
            "imagePosition": "right",
          },
        ],
      },
      {
        "id": 2,
        "question": "When I think about dessert",
        "image": "assets/assessment/EAT_HEALTHY_2.jpg",
        "options": [
          {
            "text": "I'll enjoy a fruit salad",
            "trait": "HealthyEater",
            "score": 3,
            "imagePosition": "left",
          },
          {
            "text": "I'll eat ice cream or cake",
            "trait": "SweetTooth",
            "score": 1,
            "imagePosition": "right",
          },
        ],
      },
      {
        "id": 3,
        "question": "When I think about Toppings",
        "image": "assets/assessment/EAT_HEALTHY_3.jpg",
        "options": [
          {
            "text": "I'll use olive oil or avocado as a topping",
            "trait": "HealthyEater",
            "score": 3,
            "imagePosition": "left",
          },
          {
            "text": "I'll add mayonnaise or creamy dressings",
            "trait": "FattyChoices",
            "score": 1,
            "imagePosition": "right",
          },
        ],
      },
      {
        "id": 4,
        "question": "When I drink something",
        "image": "assets/assessment/EAT_HEALTHY_4.jpg",
        "options": [
          {
            "text": "I drink water or buttermilk",
            "trait": "HealthyDrinker",
            "score": 3,
            "imagePosition": "left",
          },
          {
            "text": "I drink cola or sugary drinks",
            "trait": "SugaryDrinker",
            "score": 1,
            "imagePosition": "right",
          },
        ],
      },
      {
        "id": 5,
        "question": "When I plan for a lunch",
        "image": "assets/assessment/EAT_HEALTHY_5.jpg",
        "options": [
          {
            "text": "I eat roti, rice, dal, and sabzi",
            "trait": "BalancedEater",
            "score": 3,
            "imagePosition": "left",
          },
          {
            "text": "I eat biryani or fried snacks",
            "trait": "UnhealthyChoices",
            "score": 1,
            "imagePosition": "right",
          },
        ],
      },
      {
        "id": 6,
        "question": "When I'm choosing snacks",
        "image": "assets/assessment/EAT_HEALTHY_6.jpg",
        "options": [
          {
            "text": "I'll eat fresh fruit",
            "trait": "HealthyEater",
            "score": 3,
            "imagePosition": "left",
          },
          {
            "text": "I'll have a milkshake",
            "trait": "SweetTooth",
            "score": 1,
            "imagePosition": "right",
          },
        ],
      },
      {
        "id": 7,
        "question": "When I think about dinner",
        "image": "assets/assessment/EAT_HEALTHY_7.jpg",
        "options": [
          {
            "text": "I'll cook veggies and chicken",
            "trait": "HealthyEater",
            "score": 3,
            "imagePosition": "left",
          },
          {
            "text": "I'll order pizza",
            "trait": "UnhealthyChoices",
            "score": 1,
            "imagePosition": "right",
          },
        ],
      },
      {
        "id": 8,
        "question": "When I want something sweet",
        "image": "assets/assessment/EAT_HEALTHY_8.jpg",
        "options": [
          {
            "text": "I have a piece of dark chocolate",
            "trait": "SmartChoices",
            "score": 2,
            "imagePosition": "left",
          },
          {
            "text": "I have laddu and or a lot of sweets",
            "trait": "SweetTooth",
            "score": 1,
            "imagePosition": "right",
          },
        ],
      },
      {
        "id": 9,
        "question": "On a cheat day, when you get a craving for pizza",
        "image": "assets/assessment/IMG_0525.JPG",
        "options": [
          {
            "text": "I ordered a single slice to satisfy craving",
            "trait": "ModerateEater",
            "score": 2,
            "imagePosition": "left",
          },
          {
            "text": "I ordered three slices of pizza to feel full",
            "trait": "UnhealthyChoices",
            "score": 1,
            "imagePosition": "right",
          },
        ],
      },
      {
        "id": 10,
        "question": "What is your definition of healthy food?",
        "image": "assets/assessment/IMG_0526.JPG",
        "options": [
          {
            "text": "Low-fat noodles and snacks with Diet Coke",
            "trait": "MisleadingChoices",
            "score": 1,
            "imagePosition": "left",
          },
          {
            "text": "A proper, balanced meal full of nutrients",
            "trait": "HealthyEater",
            "score": 3,
            "imagePosition": "right",
          },
        ],
      },
    ],
    "profiles": {
      "HealthyEater": {
        "title": "🌟 The Healthy Eater",
        "description":
            "You have excellent eating habits! You make conscious choices and prioritize nutrition in your diet.",
        "tips": [
          "Keep up your great habits!",
          "Continue choosing whole foods",
          "Maintain balanced nutrition",
          "Stay hydrated with water",
        ],
        "score": "80-100",
      },
      "BalancedEater": {
        "title": "⚖️ The Balanced Eater",
        "description":
            "You maintain a good balance in your diet. You enjoy traditional healthy meals with proper portions.",
        "tips": [
          "Continue eating balanced meals",
          "Mix healthy and occasional treats",
          "Add more colorful vegetables",
          "Stay consistent with your routine",
        ],
        "score": "60-79",
      },
      "ModerateEater": {
        "title": "🎯 The Moderate Eater",
        "description":
            "You practice moderation in your eating habits. You enjoy treats but control your portions.",
        "tips": [
          "Control portion sizes",
          "Add more vegetables to meals",
          "Reduce sugary drinks",
          "Plan meals in advance",
        ],
        "score": "40-59",
      },
      "SmartChoices": {
        "title": "💡 The Smart Chooser",
        "description":
            "You make intelligent food choices like dark chocolate instead of regular sweets.",
        "tips": [
          "Expand your healthy swaps",
          "Learn about nutrition labels",
          "Try more healthy alternatives",
          "Educate yourself on nutrition",
        ],
        "score": "50-70",
      },
      "SweetTooth": {
        "title": "🍰 The Sweet Tooth",
        "description":
            "You love sweet things! While treats are okay occasionally, moderation is key.",
        "tips": [
          "Gradually reduce sugar intake",
          "Try healthier dessert alternatives",
          "Drink more water",
          "Set limits on sweet treats",
        ],
        "score": "20-40",
      },
      "UnhealthyChoices": {
        "title": "⚠️ Time to Change",
        "description":
            "Your current eating habits may need improvement. But don't worry, it's never too late to start!",
        "tips": [
          "Start with small dietary changes",
          "Replace sugary drinks with water",
          "Add one healthy meal per day",
          "Consult a nutritionist",
          "Read nutrition labels",
          "Plan balanced meals",
        ],
        "score": "10-30",
      },
      "FattyChoices": {
        "title": "🚨 Watch the Fat Intake",
        "description":
            "Your fat and calorie intake may be higher than recommended. Let's make some adjustments.",
        "tips": [
          "Use healthy oils in moderation",
          "Replace creamy dressings with oil and vinegar",
          "Grill instead of frying",
          "Choose low-fat alternatives",
          "Read food labels carefully",
        ],
        "score": "15-35",
      },
      "SugaryDrinker": {
        "title": "🥤 Reduce Sugar Intake",
        "description":
            "Sugary drinks are a major source of hidden calories. Let's switch to healthier options.",
        "tips": [
          "Replace sugary drinks with water",
          "Try herbal teas and lemon water",
          "Cut down gradually on sugar",
          "Avoid energy drinks and sodas",
          "Drink milk or buttermilk instead",
        ],
        "score": "15-35",
      },
      "HealthyDrinker": {
        "title": "💧 The Healthy Drinker",
        "description":
            "You make excellent beverage choices! Water and buttermilk are perfect for health.",
        "tips": [
          "Keep drinking plenty of water",
          "Continue with healthy beverages",
          "Try adding lemon or cucumber to water",
          "Stay hydrated throughout the day",
        ],
        "score": "75-95",
      },
      "MisleadingChoices": {
        "title": "⚠️ Rethink Your Choices",
        "description":
            "Some popular 'diet' foods may not be as healthy as they seem. Let's educate ourselves!",
        "tips": [
          "Avoid 'diet' versions of sugary drinks",
          "Low-fat doesn't mean healthy",
          "Read labels carefully",
          "Choose whole foods over processed",
          "Learn about hidden sugars and chemicals",
          "Consult with a nutritionist",
        ],
        "score": "10-25",
      },
    },
  },
};
