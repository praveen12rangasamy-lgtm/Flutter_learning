import '../../features/events/models/event.dart';

class MockData {
  MockData._();

  static const List<Event> sampleEvents = [
    Event(
      id: 1,
      title: 'Inclusive Tech & Flutter Summit 2026',
      description:
          'Join developers, designers, and community leaders to discuss cross-platform development, AI accessibility, and modern mobile app architecture. Network with industry experts and discover breakthrough innovations.',
      location: 'Chennai Trade Centre, Chennai',
      date: '15 September 2026',
      time: '10:00 AM',
      category: 'Conference',
    ),
    Event(
      id: 2,
      title: 'KnotNex Hackathon: Empowering Every Ability',
      description:
          'A 24-hour collaborative hackathon building assistive technologies and inclusive applications for specially-abled individuals. Mentorship and exciting prizes for winning teams.',
      location: 'Bengaluru Innovation Hub, Bengaluru',
      date: '22 September 2026',
      time: '09:30 AM',
      category: 'Hackathon',
    ),
    Event(
      id: 3,
      title: 'Mobile UI/UX Masterclass & Design Systems',
      description:
          'Hands-on masterclass focusing on accessible UI components, fluid animations, typography hierarchy, and state-of-the-art Flutter architecture for production-grade apps.',
      location: 'Online / Virtual Live',
      date: '28 September 2026',
      time: '02:00 PM',
      category: 'Workshop',
    ),
    Event(
      id: 4,
      title: 'Global Assistive Tech & Career Expo',
      description:
          'Connect with leading NGOs, inclusive service providers, volunteers, and organizations. Discover career pathways and assistive technology advancements in one unified venue.',
      location: 'Hyderabad Convention Hall, Hyderabad',
      date: '05 October 2026',
      time: '11:00 AM',
      category: 'Exhibition',
    ),
    Event(
      id: 5,
      title: 'AI in Rehabilitation & Healthcare Meetup',
      description:
          'Explore machine learning models, smart prosthetics, computer vision tools, and adaptive technology transforming rehabilitation and daily accessibility.',
      location: 'Mumbai Tech Park, Mumbai',
      date: '12 October 2026',
      time: '10:30 AM',
      category: 'Meetup',
    ),
  ];
}
