class Place {
  final String id;
  final String name;
  final String description;
  final String shortDescription;
  final String imageUrl;
  final double rating;
  final int duration;
  final String pickupTime;
  final int maxGroupSize;
  final bool mealsIncluded;
  final double price;
  final List<String> highlights;
  final String location;

  const Place({
    required this.id,
    required this.name,
    required this.description,
    required this.shortDescription,
    required this.imageUrl,
    required this.rating,
    required this.duration,
    required this.pickupTime,
    required this.maxGroupSize,
    required this.mealsIncluded,
    required this.price,
    required this.highlights,
    required this.location,
  });
}

// Sample data for Sharm El Sheikh places
final List<Place> sharmElSheikhPlaces = [
  Place(
    id: '1',
    name: 'Ras Mohammed National Park',
    shortDescription: 'Egypt\'s first national park with coral reefs',
    description: 'Discover the underwater paradise of Ras Mohammed National Park, home to some of the world\'s most spectacular coral reefs and marine life. This protected area offers incredible snorkeling and diving opportunities in crystal-clear waters.',
    imageUrl: 'https://images.unsplash.com/photo-1583212292454-1fe6229603b7?ixlib=rb-4.0.3&auto=format&fit=crop&w=2000&q=80',
    rating: 4.8,
    duration: 8,
    pickupTime: '8:00 AM',
    maxGroupSize: 15,
    mealsIncluded: true,
    price: 85.0,
    highlights: ['Snorkeling', 'Marine life', 'Coral reefs', 'Photography'],
    location: 'Ras Mohammed, Sharm El Sheikh',
  ),
  Place(
    id: '2',
    name: 'Mount Sinai & St. Catherine',
    shortDescription: 'Sacred mountain and ancient monastery',
    description: 'Experience the spiritual journey to Mount Sinai, where Moses received the Ten Commandments. Visit the historic St. Catherine Monastery and witness breathtaking sunrise views from the summit.',
    imageUrl: 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&auto=format&fit=crop&w=2000&q=80',
    rating: 4.9,
    duration: 12,
    pickupTime: '1:00 AM',
    maxGroupSize: 20,
    mealsIncluded: true,
    price: 120.0,
    highlights: ['Sunrise viewing', 'Historical sites', 'Hiking', 'Spiritual experience'],
    location: 'Mount Sinai, South Sinai',
  ),
  Place(
    id: '3',
    name: 'Blue Hole Dahab',
    shortDescription: 'World-famous diving destination',
    description: 'Explore the legendary Blue Hole, one of the world\'s most famous diving spots. This natural wonder offers incredible underwater experiences with its deep blue waters and diverse marine ecosystem.',
    imageUrl: 'https://images.unsplash.com/photo-1559827260-dc66d52bef19?ixlib=rb-4.0.3&auto=format&fit=crop&w=2000&q=80',
    rating: 4.7,
    duration: 10,
    pickupTime: '7:00 AM',
    maxGroupSize: 12,
    mealsIncluded: true,
    price: 95.0,
    highlights: ['Diving', 'Snorkeling', 'Marine photography', 'Adventure'],
    location: 'Dahab, South Sinai',
  ),
  Place(
    id: '4',
    name: 'Colored Canyon',
    shortDescription: 'Natural rock formations and hiking',
    description: 'Journey through the stunning Colored Canyon with its multicolored rock formations and narrow passages. This geological wonder offers excellent hiking opportunities and spectacular photo opportunities.',
    imageUrl: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?ixlib=rb-4.0.3&auto=format&fit=crop&w=2000&q=80',
    rating: 4.6,
    duration: 6,
    pickupTime: '9:00 AM',
    maxGroupSize: 18,
    mealsIncluded: false,
    price: 65.0,
    highlights: ['Hiking', 'Photography', 'Geology', 'Adventure'],
    location: 'Nuweiba, South Sinai',
  ),
  Place(
    id: '5',
    name: 'Tiran Island',
    shortDescription: 'Pristine coral reefs and snorkeling',
    description: 'Discover the pristine coral reefs surrounding Tiran Island. This protected marine area offers some of the best snorkeling in the Red Sea with crystal-clear waters and abundant marine life.',
    imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?ixlib=rb-4.0.3&auto=format&fit=crop&w=2000&q=80',
    rating: 4.8,
    duration: 7,
    pickupTime: '9:30 AM',
    maxGroupSize: 16,
    mealsIncluded: true,
    price: 75.0,
    highlights: ['Snorkeling', 'Boat trip', 'Marine life', 'Coral reefs'],
    location: 'Tiran Island, Red Sea',
  ),
  Place(
    id: '6',
    name: 'White Canyon',
    shortDescription: 'Unique white limestone formations',
    description: 'Explore the mesmerizing White Canyon with its unique white limestone formations and narrow corridors. This hidden gem offers a peaceful hiking experience away from the crowds.',
    imageUrl: 'https://images.unsplash.com/photo-1506197603052-3cc9c3a201bd?ixlib=rb-4.0.3&auto=format&fit=crop&w=2000&q=80',
    rating: 4.5,
    duration: 5,
    pickupTime: '10:00 AM',
    maxGroupSize: 14,
    mealsIncluded: false,
    price: 55.0,
    highlights: ['Hiking', 'Photography', 'Peaceful', 'Unique formations'],
    location: 'Dahab, South Sinai',
  ),
];

// Sample banner images for auto-scroll
final List<String> bannerImages = [
  'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?ixlib=rb-4.0.3&auto=format&fit=crop&w=2000&q=80',
  'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?ixlib=rb-4.0.3&auto=format&fit=crop&w=2000&q=80',
  'https://images.unsplash.com/photo-1583212292454-1fe6229603b7?ixlib=rb-4.0.3&auto=format&fit=crop&w=2000&q=80',
  'https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&auto=format&fit=crop&w=2000&q=80',
  'https://images.unsplash.com/photo-1559827260-dc66d52bef19?ixlib=rb-4.0.3&auto=format&fit=crop&w=2000&q=80',
];