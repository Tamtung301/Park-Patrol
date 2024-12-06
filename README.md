# Park Patrol

## Overview
Park Patrol is an iOS application developed by Hector Mojica and Daniel Wright for their iOS Programming course at California State University, Fullerton. The app helps CSUF students stay informed about parking patrol activities on campus, allowing them to share and receive parking enforcement information.

## Developers
- Hector Mojica
- Daniel Wright

## Requirements
- iOS 16.6 or later
- iPhone with location services
- Xcode 14+ for development

## Features
- Interactive map for viewing and reporting patrol locations
- User profiles with customizable information
- Location-based alert system
- Dark/Light theme options
- Alert history tracking
- Push notification support

## Technical Components

### Frameworks Used
- SwiftUI for the user interface
- MapKit for mapping functionality
- CoreLocation for location services
- CoreData for storing reports
- UserDefaults for saving user preferences

### Main Views
1. **Home Screen**
   - Interactive map
   - Location reporting
   - Alert notifications

2. **Profile Section**
   - User information
   - Profile photo
   - Alert history

3. **Settings**
   - Theme selection
   - Notification preferences
   - App configuration

4. **About Section**
   - App information
   - Feature descriptions
   - Usage instructions

### Data Storage
The app uses CoreData to store parking patrol reports with the following information:
- Date and time
- Location name
- Coordinates (latitude/longitude)

## Required Permissions
The app needs access to:
- Location Services (When In Use)
- Photo Library (Optional, for profile photos)
- Push Notifications (Optional)

## Course Project Details
This application was developed as part of the iOS Programming course at CSUF. It demonstrates our understanding of:
- iOS app development
- User interface design
- Location-based services
- Data persistence
- SwiftUI programming

## Future Updates
Planned features include:
- Real-time notifications
- Additional map features
- Extended campus coverage
- Enhanced user profiles

## Acknowledgments
Special thanks to our course instructor and teaching assistants for their guidance throughout the development process.
