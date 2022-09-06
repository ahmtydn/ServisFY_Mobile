class Chat {
  final String name, lastMessage, image, time;
  final bool isActive;

  Chat({
    this.name = '',
    this.lastMessage = '',
    this.image = '',
    this.time = '',
    this.isActive = false,
  });
}

List chatsData = [
  Chat(
    image: 'images/avatar.png',
    name: 'Ahmet Aydın',
    lastMessage: '5 dk ya oradayız',
    time: "3 dk önce",
    isActive: true,
  ),
  Chat(
    image: 'images/hakan.jpeg',
    name: 'Hakan Böbrek',
    lastMessage: 'Okulda',
    time: "1s önce",
    isActive: false,
  ),
  Chat(
    image: 'images/murat.jpg',
    name: 'Murat Sado',
    lastMessage: 'bu gün çalışmıyorum',
    time: "15 dk önce",
    isActive: false,
  ),
  Chat(
    image: 'images/ugur.jpg',
    name: 'Uğur Öztürk',
    lastMessage: 'Saat kaçta ?',
    time: "1 dk önce",
    isActive: true,
  ),
  Chat(
    image: 'images/aysu.jpg',
    name: 'Aysu Çakmak',
    lastMessage: 'Hayır',
    time: "1 gün önce",
    isActive: false,
  ),
  Chat(
    image: 'images/ezgi.jpg',
    name: 'Ezgi  Yılmaz',
    lastMessage: 'Tamam.',
    time: "1 hafta önce",
    isActive: false,
  ),
];
