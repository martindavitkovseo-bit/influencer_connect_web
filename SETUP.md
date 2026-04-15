# Influencer Connect Web - Quick Start Guide

## Setup Instructions

### 1. Prerequisites
- Flutter SDK 3.3.0+ from [flutter.dev](https://flutter.dev)
- Git
- A modern web browser (Chrome recommended)

### 2. Initial Setup

#### Windows
```bash
run.bat
```

#### Mac/Linux
```bash
chmod +x run.sh
./run.sh
```

#### Manual Setup
```bash
flutter pub get
flutter run -d chrome
```

### 3. Environment Configuration

Before running the app, configure your backend services:

#### Firebase Setup
1. Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
2. Create a web app in Firebase
3. Update `lib/main.dart` with your Firebase config:
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

#### Supabase Setup
1. Create a Supabase project at [supabase.com](https://supabase.com)
2. Update `lib/src/core/config/app_config.dart`:
```dart
static const String supabaseUrl = 'https://your-project.supabase.co';
static const String supabaseAnonKey = 'your-anon-key';
```

### 4. Database Schema (Supabase)

Create these tables in your Supabase database:

#### users
```sql
CREATE TABLE users (
  id UUID PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  type TEXT NOT NULL, -- 'influencer' or 'business'
  bio TEXT,
  profile_image_url TEXT,
  category TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### campaigns
```sql
CREATE TABLE campaigns (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  business_id UUID REFERENCES users(id),
  title TEXT NOT NULL,
  description TEXT,
  budget DECIMAL,
  duration_months INTEGER,
  target_categories TEXT[],
  status TEXT DEFAULT 'active',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  end_date TIMESTAMP
);
```

#### collaboration_requests
```sql
CREATE TABLE collaboration_requests (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  campaign_id UUID REFERENCES campaigns(id),
  influencer_id UUID REFERENCES users(id),
  business_id UUID REFERENCES users(id),
  proposed_budget DECIMAL,
  status TEXT DEFAULT 'pending',
  message TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  responded_at TIMESTAMP
);
```

### 5. Running the Application

#### Development Mode
```bash
flutter run -d chrome
```

#### Production Build
```bash
flutter build web --release
```

The release build will be in `build/web/`

### 6. File Structure

```
lib/
├── main.dart                 # Entry point
├── src/
│   ├── app.dart             # App root widget
│   ├── core/
│   │   ├── config/          # Configuration
│   │   ├── constants/       # Constants
│   │   ├── providers/       # Riverpod providers
│   │   ├── router/          # GoRouter setup
│   │   └── services/        # API services
│   └── features/
│       ├── auth/            # Authentication
│       ├── business/        # Business features
│       ├── influencer/      # Influencer features
│       ├── influencers/     # Influencer discovery
│       ├── profiles/        # Profile management
│       ├── requests/        # Request management
│       └── shared/          # Shared widgets
web/
├── index.html               # Web entry point
└── manifest.json            # PWA config
```

## Features

### Authentication
- [x] Login page
- [x] Registration page
- [x] User type selection (Influencer/Business)
- [ ] Email verification
- [ ] Password reset

### Influencer Features
- [x] Profile management
- [x] Dashboard with stats
- [x] Browse opportunities
- [x] Apply for collaborations
- [x] View requests
- [x] Influencer discovery

### Business Features
- [x] Business dashboard
- [x] Create campaigns
- [x] Search influencers
- [x] Manage requests
- [x] Campaign management

### General
- [x] Responsive design
- [x] State management with Riverpod
- [x] Routing with GoRouter
- [ ] Real-time notifications
- [ ] Payment integration
- [ ] Analytics dashboard

## Deployment

### Deploy to Vercel
1. Build the app: `flutter build web --release`
2. Push `build/web` to a Git repository
3. Connect to Vercel and deploy

### Deploy to Firebase Hosting
```bash
# Install Firebase CLI
npm install -g firebase-tools

# Build the app
flutter build web --release

# Deploy
firebase deploy
```

### Deploy to Netlify
1. Build the app: `flutter build web --release`
2. Upload `build/web` folder to Netlify

## Troubleshooting

### Port already in use
Change the port:
```bash
flutter run -d chrome --web-port=5001
```

### Clear build artifacts
```bash
flutter clean
flutter pub get
```

### Check for errors
```bash
flutter analyze
```

## Support & Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [GoRouter Documentation](https://pub.dev/packages/go_router)
- [Riverpod Documentation](https://riverpod.dev)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Supabase Documentation](https://supabase.com/docs)

## Next Steps

1. ✅ Set up Firebase and Supabase
2. ✅ Create database schema
3. ✅ Configure API keys
4. ✅ Run `flutter pub get`
5. ✅ Run the app: `flutter run -d chrome`
6. Make sure you login works
7. Test all features
8. Build and deploy

Happy coding! 🚀
