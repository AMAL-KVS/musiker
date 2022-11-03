// Container(
//                 width: 500,
//                 height: 251,
//                 decoration: const BoxDecoration(
//                     borderRadius:
//                         BorderRadius.only(bottomLeft: Radius.circular(100)),
//                     color: Color.fromARGB(255, 36, 35, 34)),
//                 child: Column(
//                   children: [
//                     Expanded(
//                         child: ListView(
//                       scrollDirection: Axis.horizontal,
//                       children: [
//                         const SizedBox(
//                           width: 40,
//                         ),
//                         InkWell(
//                           child: Container(
//                             width: 150,
//                             height: 50,
//                             child: Column(
//                               children: [
//                                 const SizedBox(
//                                   height: 30,
//                                 ),
//                                 Image.asset('assets/images/playlist.jpg'),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 Text(
//                                   'P l a y l i s t',
//                                   style: GoogleFonts.montserrat(
//                                       color: Colors.white),
//                                 )
//                               ],
//                             ),
//                           ),
//                           onTap: () {
//                             Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (ctx) => PlayList()));
//                           },
//                         ),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         InkWell(
//                           child: Container(
//                             width: 150,
//                             height: 50,
//                             child: Column(
//                               children: [
//                                 const SizedBox(
//                                   height: 30,
//                                 ),
//                                 Image.asset('assets/images/favori.png'),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 Text(
//                                   'F a v o r i s t s',
//                                   style: GoogleFonts.montserrat(
//                                       color: Colors.white),
//                                 )
//                               ],
//                             ),
//                           ),
//                           onTap: () {
//                             Navigator.of(context).push(
//                                 MaterialPageRoute(builder: (ctx) => Favor()));
//                           },
//                         ),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         InkWell(
//                           child: Container(
//                             height: 50,
//                             width: 150,
//                             child: Column(
//                               children: [
//                                 const SizedBox(
//                                   height: 30,
//                                 ),
//                                 Image.asset('assets/images/recent.png'),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 Text(
//                                   'R e c e n t',
//                                   style: GoogleFonts.montserrat(
//                                       color: Colors.white),
//                                 )
//                               ],
//                             ),
//                           ),
//                           onTap: () {
//                             Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (ctx) => ScreenRecent()));
//                           },
//                         ),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         InkWell(
//                           child: Container(
//                             height: 50,
//                             width: 150,
//                             child: Column(
//                               children: [
//                                 const SizedBox(
//                                   height: 30,
//                                 ),
//                                 Image.asset('assets/images/most.jpg'),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 Text(
//                                   'M o s t   P l a y e d',
//                                   style: GoogleFonts.montserrat(
//                                       color: Colors.white),
//                                 )
//                               ],
//                             ),
//                           ),
//                           onTap: () {
//                             Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (ctx) => ScreenMostPlay()));
//                           },
//                         ),
//                       ],
//                     ))
//                   ],
//                 ))