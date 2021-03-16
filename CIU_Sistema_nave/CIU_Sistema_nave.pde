import gifAnimation.*;

Astro[] system = new Astro[23];
boolean[] positon = {false, false, false, false};
GifMaker gifExport;
int frames = 0;
int totalFrames = 60;

class nave {

  Point position;
  Point camara; 
  
  nave (float x, float y, float z) {
    position = new Point(x, y, z);
    camara = new Point(0, 0, 0);
  }
  
  void display() {
    move_camara();
    move_nave();
  }
  
  void move_camara() {
    camara.x += mouseX - pmouseX;
    camara.y += mouseY - pmouseY;
    
  }
  
  void move_nave(){  
      if (positon[0]) position.y -= 100;
      if (positon[1]) position.y += 100;
      if (positon[2]) position.x -= 100;
      if (positon[3]) position.x += 100;
  }
}

void keyPressed() {
     if (key == 'w') positon[0] = true;
     if (key == 's') positon[1] = true;
     if (key == 'a') positon[2] = true;
     if (key == 'd') positon[3] = true;
     if (key == ' ') vision_mode = (vision_mode) ? false : true;
}

void keyReleased() {
     if (key == 'w') positon[0] = false;
     if (key == 's') positon[1] = false;
     if (key == 'a') positon[2] = false;
     if (key == 'd') positon[3] = false;
}

class Point {

  float x, y, z;
  
  Point (float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
}

float gr_to_rd(float gr) {
  return gr * PI / 180;
}


class Astro {

  Astro orbit_astro;
  Point position;
  float velocidad;
  float size;
  float inclinacion_orbital;
  String name = "";
  
  Astro(float velocidad_angular, Point position, float size, float inclinacion_orbital) {
    this.velocidad = velocidad_angular;
    this.position = position;
    this.size = size;
    this.inclinacion_orbital = inclinacion_orbital;
  }
  
  Point rotar_point(Point point){
    float x_ = point.x * cos(gr_to_rd(velocidad)) - point.z * sin(gr_to_rd(velocidad));
    float y_ = point.y;
    float z_ = point.x * sin(gr_to_rd(velocidad)) + point.z * cos(gr_to_rd(velocidad));
    return new Point(x_, y_, z_);
  }
  
  void set_name(String name) {
    this.name = name;
  }
  
  void set_orbit(Astro orbit_astro) {
    this.orbit_astro = orbit_astro;
  }
  
  void display () {
    pushMatrix();
    stroke(240, 240, 240);
    if (orbit_astro != null)
      translate(orbit_astro.position.x, orbit_astro.position.y, orbit_astro.position.z);
      
    position = rotar_point(position);
    rotateZ(gr_to_rd(inclinacion_orbital));
    translate(position.x, position.y, position.z + 200);
    sphere(size);
    textSize(24);
    text(name, 10, 30); 
    fill(255,0,0);
    popMatrix();
  }
  
}



void setup() {
  smooth();
  size(1000, 1000, P3D);
  background(0);
  
  /*
  gifExport = new GifMaker(this, "animation.gif", 100);
  gifExport.setRepeat(0); 
  **/
   
  //star
  Astro center = new Astro(0, new Point(0, 0, 0), 0, 0);
  
  Astro sol = new Astro(5.0, new Point(-400, 0, 0), 100, -30);
  Astro sol_1 = new Astro(5.0, new Point(400, 0, 0), 100, 30);
  sol.set_orbit(center);
  sol_1.set_orbit(center);
  sol.set_name("sol_0");
  sol_1.set_name("sol_1");
  
  //planets
  Astro mercury = new Astro(17.404,  new Point(150.0, 0, 0), 00.5, 7);
  mercury.set_orbit(center);
  
  Astro venus = new Astro(12.108, new Point(300.0, 0, 0), 20, 3.3);
  venus.set_orbit(center);
  
  Astro earth = new Astro(10.244, new Point(400.0, 0, 0), 20, 0);
  earth.set_orbit(center);
  earth.set_name("Tierra");
  
  Astro mars = new Astro(8.868, new Point(600.0, 0, 0), 30, 1);
  mars.set_orbit(center);
  
  Astro jupiter = new Astro(4.016, new Point(770.0, 0, 0), 70, 1.3);
  jupiter.set_orbit(center);
  
  Astro saturn = new Astro(3.705, new Point(1420.0, 0, 0), 50, 2.4);
  saturn.set_orbit(center);
  
  Astro uranus = new Astro(2.516, new Point(2870.0, 0, 0), 40, 0.7);
  uranus.set_orbit(center);
  
  Astro neptunus = new Astro(1.548, new Point(4500.0, 0, 0), 40, 1.8);
  neptunus.set_orbit(center);
  
  
  //satelite
  Astro VE = new Astro(3.5, new Point(200.0, 0, 0), 10, 3);
  VE.set_orbit(venus);
  
  Astro moon = new Astro(1, new Point(0.3, 0, 0), 10, 5.1);
  moon.set_orbit(earth);
  
  Astro ceres = new Astro(3.5, new Point(6000.0, 0, 0), 20, 10.5);
  ceres.set_orbit(center);
  
  Astro pluto = new Astro(3.5, new Point(5901.0, 0, 0), 20.3, 17.1);
  pluto.set_orbit(center);
  
  Astro eris = new Astro(3.5, new Point(6100.0, 0, 0), 10, 44);
  eris.set_orbit(sol);
  
  Astro j_moon_1 = new Astro(3.5, new Point(100.0, 0, 0), 0.3, 4);
  j_moon_1.set_orbit(jupiter);
  Astro j_moon_2 = new Astro(4.5, new Point(102.0, 0, 0), 0.3, 8);
  j_moon_2.set_orbit(jupiter);
  Astro j_moon_3 = new Astro(1.5, new Point(104.0, 0, 0), 0.3, 12);
  j_moon_3.set_orbit(jupiter);
  Astro j_moon_4 = new Astro(7.5, new Point(16.0, 0, 0), 0.3, 14);
  j_moon_4.set_orbit(jupiter);
  Astro j_moon_5 = new Astro(3.5, new Point(18.0, 0, 0), 0.3, 20);
  j_moon_5.set_orbit(jupiter);
  Astro j_moon_6 = new Astro(9.5, new Point(20.0, 0, 0), 0.3, 26);
  j_moon_6.set_orbit(jupiter);
  Astro j_moon_7 = new Astro(0.5, new Point(22.0, 0, 0), 0.1, 44);
  j_moon_7.set_orbit(jupiter);
  
  nav = new nave(0, 0, 0);
  
  system[0] = sol;
  system[1] = mercury;
  system[2] = venus;
  system[3] = VE;  
  system[4] = earth;
  system[5] = eris;
  system[6] = pluto;
  system[7] = ceres;  
  system[8] = moon;
  system[9] = neptunus;
  system[10] = uranus;
  system[11] = saturn;  
  system[13] = mars;
  
  system[14] = j_moon_1;
  system[15] = j_moon_2;
  system[16] = j_moon_3;
  system[17] = j_moon_4;
  system[18] = j_moon_5;
  system[19] = j_moon_6;
  system[20] = j_moon_7;
  
  system[12] = jupiter;
  system[21] = sol_1;
  system[22] = center;
}


void display(){
  for (int i = 0; i < system.length; i++) {
    system[i].display();
  }
}

nave nav;
boolean vision_mode;

void draw () {
  background (0);    
  translate(0, 0, 0);
  textSize(32);
  
  if (vision_mode) {
    nav.display();
    camera( width/2.0+nav.position.x + nav.camara.x  , height /2.0 + nav.camara.y, ( height / 2.0 ) / tan ( PI *30.0 / 180.0 )+nav.position.y ,
            width / 2.0 , height / 2.0 , 0 , 0 ,1 , 0);
  } else {
    camera();
    translate(0, 0, 0);
    text("Modo Panoramico", 10, height);
    text("Controles: movimiento nave (wasd + raton)\r\n cambio modo barra espaciadora", 50, 30); 
    translate(30, 30, -5330);
  }
  
  rotateX(gr_to_rd(-30));
  display();
  delay(60);

  
  /*
  export();
  export();
  **/
}

void export() {
  if(frames < totalFrames) {
    gifExport.setDelay(20);
    gifExport.addFrame();
    frames++;
  } else {
    gifExport.finish();
    frames++;
    println("gif saved");
    exit();
  }
}
