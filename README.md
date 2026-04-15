# Influencer Connect - Web Platform

A Flutter Web application for the Influencer Connect marketplace platform.

## Features

### Authentication
- User registration and login
- Support for Influencer and Business accounts
- Secure authentication with Firebase & Supabase

### Influencer Features
- Complete profile management
- Browse available opportunities
- Apply for collaborations
- Track pending and accepted requests
- View earnings and statistics

### Business Features
- Create and manage campaigns
- Search and connect with influencers
- Track collaboration requests
- Manage business profile
- Campaign analytics

### General
- Responsive design for desktop and tablet
- Real-time notifications (web-adapted)
- Secure data storage with Firestore
- Supabase integration for additional data
- State management with Riverpod
- GoRouter for navigation

## Project Structure

```
lib/
├── main.dart                 # Entry point
├── src/
│   ├── app.dart             # App configuration
│   ├── core/
│   │   ├── config/          # App configuration
│   │   ├── constants/       # App constants
│   │   ├── providers/       # Riverpod providers
│   │   ├── router/          # GoRouter setup
│   │   └── services/        # Services
│   └── features/
│       ├── auth/            # Authentication feature
│       ├── business/        # Business dashboard
│       ├── influencer/      # Influencer dashboard
│       ├── profiles/        # Profile management
│       ├── requests/        # Request management
│       └── shared/          # Shared components
web/
├── index.html               # Web entry point
└── manifest.json            # PWA manifest
```

## Getting Started

### Prerequisites
- Flutter SDK (3.3.0 or higher)
- Chrome browser for local development
- Git

### Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd influencer_connect_web
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Configure Firebase and Supabase:
   - Update `lib/src/core/config/app_config.dart` with your API keys
   - Ensure Firebase and Supabase projects are set up

### Development

Run the development server:
```bash
flutter run -d chrome
```

The app will be available at `http://localhost:5000`

### Build for Production

Build a release version:
```bash
flutter build web --release
```

The built files will be in `build/web/`

## Configuration

### Firebase Setup
Update the Firebase configuration in `lib/main.dart`:
```dart
await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: 'YOUR_API_KEY',
    appId: 'YOUR_APP_ID',
    messagingSenderId: 'YOUR_SENDER_ID',
    projectId: 'YOUR_PROJECT_ID',
  ),
);
```

### Supabase Setup
Update Supabase credentials in `lib/src/core/config/app_config.dart`:
```dart
static const String supabaseUrl = 'https://your-project.supabase.co';
static const String supabaseAnonKey = 'your-anon-key';
```

## Routes

| Route | Description |
|-------|-------------|
| `/` | Home/Redirect page |
| `/login` | Login page |
| `/register` | Registration page |
| `/dashboard` | User dashboard |
| `/profile` | User profile |
| `/business` | Business dashboard |
| `/influencer` | Influencer dashboard |
| `/requests` | Collaboration requests |

## Dependencies

- **flutter_riverpod**: State management
- **go_router**: Routing and navigation
- **firebase_core**: Firebase initialization
- **firebase_auth**: Authentication
- **cloud_firestore**: Database
- **firebase_storage**: File storage
- **supabase_flutter**: Supabase integration
- **http**: HTTP client

## Deployment

### Vercel/Netlify
1. Build for web: `flutter build web --release`
2. Deploy the `build/web` directory

### Docker
Create a Dockerfile in the project root:
```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY build/web ./
RUN npm install -g serve
CMD ["serve", "-s", ".", "-l", "5000"]
```

## API Integration

### Authentication Endpoints
- `POST /auth/register` - User registration
- `POST /auth/login` - User login
- `POST /auth/logout` - User logout

### Data Endpoints
- `GET /api/influencers` - List influencers
- `GET /api/campaigns` - List campaigns
- `POST /api/requests` - Create collaboration request
- `GET /api/requests` - Get user requests

## Security

- All API calls use HTTPS
- Firebase Auth handles user authentication
- Supabase Row Level Security (RLS) for data protection
- Sensitive data is stored securely

## Performance

- Lazy loading for routes
- Image optimization
- Code splitting
- Caching strategies

## Browser Support

- Chrome 90+
- Firefox 88+
- Safari 14+
- Edge 90+

## Contributing

1. Create a feature branch: `git checkout -b feature/your-feature`
2. Make your changes
3. Test thoroughly
4. Commit your changes: `git commit -am 'Add new feature'`
5. Push to the branch: `git push origin feature/your-feature`
6. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details

## Support

For issues and questions, please open an issue on the GitHub repository.
