class Building {
  String imageUrl;
  String name;
  int floors;
  int seminarHalls;

  List<String> branches;
  String info;

  Building(
      {this.imageUrl,
      this.name,
      this.floors,
      this.seminarHalls,
      this.branches,
      this.info});
}

List<Building> buildings = [
  Building(
    imageUrl: 'assets/images/building_images/KJSCE-A.png',
    name: 'K.J. Somaiya College of Engineering - Aryabhatta building',
    floors: 5,
    seminarHalls: 3,
    branches: ['EXTC', 'Mechanical'],
    info: 'KJSCE .............',
  ),
  Building(
    imageUrl: 'assets/images/building_images/KJSCE-A.png',
    name: 'K.J. Somaiya College of Engineering - B building',
    floors: 5,
    seminarHalls: 3,
    branches: ['IT', 'Computers', 'Electronics'],
    info: 'KJSCE .............',
  ),
  Building(
    imageUrl: 'assets/images/building_images/Aurobindo.jpg',
    name: 'Aurobindo',
    floors: 7,
    seminarHalls: 1,
    branches: null,
    info: 'Auro...hehe',
  ),
  Building(
    imageUrl:
        'assets/images/building_images/KJsomaiyaCollegeofArtsandCommerce.png',
    name: 'K.J. Somaiya College of Arts and Commerce',
    floors: 5,
    seminarHalls: 1,
    branches: ['Arts', 'Commerce'],
    info: 'ksks......',
  ),
  Building(
    imageUrl: 'assets/images/building_images/KJSCE-A.png',
    name: 'K. J. Somaiya Polytechnic',
    floors: 2,
    seminarHalls: 1,
    branches: [],
    info: 'Poly .............',
  ),
  Building(
    imageUrl: 'assets/images/building_images/SIMSRboysHostel.png',
    name: 'SIMSR Boys Hostel',
    floors: 11,
    seminarHalls: 1,
    branches: null,
    info: 'Boys hostel with the best amenities, not kidding.',
  ),
  Building(
    imageUrl: 'assets/images/building_images/TheSomaiyaSchool',
    name: 'The Somaiya School',
    floors: 3,
    seminarHalls: 2,
    branches: ['1-10 standard primary and high school edu.'],
    info: 'school chale ham!!',
  ),
  Building(
    imageUrl: 'assets/images/building_images/Maitrey.jpg',
    name: 'SIMSR Girls hostel',
    floors: 5,
    seminarHalls: 1,
    branches: null,
    info: 'girls hostel...',
  )
];
