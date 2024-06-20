// Import the express module
const express = require('express');

// Create an instance of an Express application
const app = express();

// Define a port for the server to listen on
const PORT = 3000;

// Middleware to parse JSON bodies
app.use(express.json());

// Define a simple route for the root URL
app.get('/', (req, res) => {
  res.send('Hello, World!');
});

// Define another route that returns a JSON response
app.get('/api/greet', (req, res) => {
  res.json({ message: 'Hello from the API!' });
  console.log('BREAKPOINT', this || 'no value');
});

// Define a POST route to demonstrate JSON handling
app.post('/api/data', (req, res) => {
  const data = req.body;
  res.json({ received: data });
});

// Start the server and listen on the defined port
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
