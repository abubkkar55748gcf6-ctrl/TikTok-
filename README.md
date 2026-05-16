# TikTok OSINT App

A comprehensive OSINT (Open Source Intelligence) application for analyzing TikTok profiles, content, and metadata.

## Features

- **Authentication System**: Secure user registration and login with JWT tokens
- **Profile Search**: Search TikTok users by various criteria
- **Content Analysis**: Analyze hashtags, sounds, captions, and engagement stats
- **Media Tools**: Image/video extraction, reverse search, face detection
- **Social Media Pivot**: Find linked accounts across platforms
- **External Search**: Integration with multiple search engines
- **Archive & History**: Track deleted content and username changes
- **Reports**: Generate comprehensive reports in PDF/JSON format
- **Admin Panel**: User management and system monitoring

## Tech Stack

### Backend
- Node.js with Express
- MongoDB for data storage
- JWT for authentication
- Bcrypt for password encryption

### Frontend
- React 18
- React Router for navigation
- Axios for HTTP requests
- CSS3 for styling

## Installation

### Prerequisites
- Node.js (v14 or higher)
- MongoDB
- npm or yarn

### Backend Setup

```bash
cd backend
npm install
cp .env.example .env
# Edit .env with your configuration
npm run dev
```

### Frontend Setup

```bash
cd frontend
npm install
npm start
```

## API Endpoints

### Authentication
- `POST /api/auth/register` - Register a new user
- `POST /api/auth/login` - Login user
- `GET /api/auth/me` - Get current user (protected)
- `POST /api/auth/logout` - Logout user

## Environment Variables

Create a `.env` file in the backend directory:

```
MONGODB_URI=mongodb://localhost:27017/tiktok-osint
JWT_SECRET=your_jwt_secret_key_here
PORT=5000
NODE_ENV=development
CLIENT_URL=http://localhost:3000
```

## Project Structure

```
.
├── backend/
│   ├── config/
│   │   └── database.js
│   ├── models/
│   │   └── User.js
│   ├── routes/
│   │   └── auth.js
│   ├── middleware/
│   │   └── auth.js
│   ├── server.js
│   ├── package.json
│   └── .env.example
├── frontend/
│   ├── src/
│   │   ├── pages/
│   │   │   ├── Login.jsx
│   │   │   ├── Register.jsx
│   │   │   └── Dashboard.jsx
│   │   ├── components/
│   │   │   └── ProtectedRoute.jsx
│   │   ├── styles/
│   │   │   ├── Auth.css
│   │   │   └── Dashboard.css
│   │   ├── App.jsx
│   │   └── package.json
└── README.md
```

## Usage

1. Start MongoDB
2. Run backend server: `npm run dev` (from backend directory)
3. Run frontend: `npm start` (from frontend directory)
4. Open http://localhost:3000 in your browser
5. Register a new account or login

## Security

- Passwords are hashed using bcrypt
- JWT tokens expire after 7 days
- Protected routes require valid authentication
- CORS enabled for frontend-backend communication

## Future Features

- TikTok API integration
- Advanced content analysis
- Real-time notifications
- Database export functionality
- Machine learning-based pattern detection

## License

ISC

## Support

For issues and feature requests, please open an issue on GitHub.
