class Building {
  String imageUrl;
  String name;
  int floors;
  int seminarHalls;
  double eta;
  List<String> branches;
  List<String> info;

  Building(
      {this.imageUrl,
      this.name,
      this.floors,
      this.seminarHalls,
      this.eta,
      this.branches,
      this.info});
}

List<Building> buildings = [
  Building(
    imageUrl: 'assets/images/building_images/KJSCE-A.png',
    name: 'K.J. Somaiya College of Engineering - Aryabhatta building',
    floors: 5,
    seminarHalls: 3,
    eta: 5,
    branches: ['EXTC', 'Mechanical'],
    info: ['KJSCE .............'],
  ),
  Building(
    imageUrl: 'assets/images/building_images/Aurobindo.jpg',
    name: 'Aurobindo',
    floors: 7,
    seminarHalls: 1,
    eta: 3,
    branches: null,
    info: ['Auro...', 'hehe'],
  ),
  Building(
    imageUrl:
        'assets/images/building_images/KJsomaiyaCollegeofArtsandCommerce.png',
    name: 'K.J. Somaiya College of Arts and Commerce',
    floors: 5,
    seminarHalls: 1,
    eta: 3,
    branches: ['Arts', 'Commerce'],
    info: ['ksks......'],
  ),
  Building(
    imageUrl: 'assets/images/building_images/SIMSRboysHostel.png',
    name: 'SIMSR Boys Hostel',
    floors: 11,
    seminarHalls: 1,
    eta: 9,
    branches: null,
    info: ['Boys hostel with the best amenities, not kidding.'],
  ),
  Building(
    imageUrl: 'assets/images/building_images/TheSomaiyaSchool',
    name: 'The Somaiya School',
    floors: 3,
    seminarHalls: 2,
    eta: 0.5,
    branches: ['1-10 standard primary and high school edu.'],
    info: ['school chale ham!!'],
  )
];
