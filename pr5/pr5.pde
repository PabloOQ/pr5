import queasycam.*;
import java.awt.event.KeyEvent;

QueasyCam cam;
ArrayList<StoreLight> cams;
ArrayList<PShape> shapes;
StoreCam viewer;
String imgPath;
String objPath;
boolean hudOn;

int currentCam;

int counter;
int step;
boolean lastFramePressed;

void settings(){
  int siz = 310;
  size(4*siz, 3*siz, P3D);
}

void setup(){
  imgPath = "../img/";
  objPath = "../obj/";
  shapes = new ArrayList<PShape>();
  counter = 0;
  step = 1;
  lastFramePressed = false;
  hudOn = true;

  cams = new ArrayList<StoreLight>();
  cam = new QueasyCam(this);
  cam.speed = 5;
  cam.sensitivity = 0.5;

  StoreLight edit;
  cams.add(new StoreLight(cam,0,0,0,0,0,StoreLight.CAM));
  cams.add(new StoreLight(cam,150,0,0,50,0,StoreLight.SPOTLIGHT));
  edit = cams.get(cams.size()-1);
  edit.getCam().position = new PVector(483,-664,1117);
  edit.getCam().pan = -2.1433;
  edit.getCam().tilt = 0.6722;

  cams.add(new StoreLight(cam,0,150,0,50,0,StoreLight.SPOTLIGHT));
  edit = cams.get(cams.size()-1);
  edit.getCam().position = new PVector(-2006,-588,663);
  edit.getCam().pan = -0.3597;
  edit.getCam().tilt = 0.2938;

  cams.add(new StoreLight(cam,0,0,150,50,0,StoreLight.SPOTLIGHT));
  edit = cams.get(cams.size()-1);
  edit.getCam().position = new PVector(572,-713,-1300);
  edit.getCam().pan = 1.9710;
  edit.getCam().tilt = 0.5928;

  currentCam = 0;

  scene();

  perspective();
}

void draw(){
  if (focused){
    cam.controllable = true;
    logic();
    show();
  }else{
    cam.controllable = false;
  }
}

void logic(){
  if (keyPressed){
    counter++;
    if (counter == 60) counter = 0;
    if (lastFramePressed){
      if (counter % 10 == 0){
        changeCamValues();
      }
    }else{
      counter = 0;
      changeCamValues();
    }
    lastFramePressed = true;
  }else{
    lastFramePressed = false;
  }
}

void show(){
  background(20);
  showCams();
  showLights();
  showShapes();
  StoreLight current = cams.get(currentCam);
  if (hudOn){
    String[] text = { "Press N to hide this help",
                    "Press WASD to move the camera, use QE to move up and down",
                    "Move your cursor to move the camera",
                    "Press SPACE to change cameras",
                    "Press or hold UJ, IK, OL to increase or decrease R,G,B",
                    "Press M to change the increase/decrease speed (step)",
                    "Press R to add a spotlight (max 8)",
                    "Press F to remove the current spotlight (min 0)",
                    "Press or hold YH to increase or decrease the angle",
                    "Press or hold TG to increase or decrease the concentration",
                    "Press ZXCVB to change the type of cam-light",
                    "",
                    "Current cam: " + (currentCam + 1) + "/" + cams.size() + ", type: "+ typeToString(current.type),
                    "r: " + current.getV1(),
                    "g: " + current.getV2(),
                    "b: " + current.getV3(),
                    "angle: " + current.getAngle(),
                    "concentration: " + current.getConcentration(),
                    "nx: " + cam.getForward().x,
                    "ny: " + cam.getForward().y,
                    "nz: " + cam.getForward().z,
                    "x: " + cam.position.x,
                    "y: " + cam.position.y,
                    "z: " + cam.position.z,
                    "pan: " + cam.pan,
                    "tilt: " + cam.tilt,
                    "",
                    "step: " + step};
    printHUDText(text);
  }else{
    String[] text = { "Press N to show help" };
    printHUDText(text);
  }
}

void showCams(){
  for (int i = 0; i < cams.size(); i++){
    StoreLight current;
    if (currentCam != i){
      current = cams.get(i);
    }else{
      StoreLight aux = cams.get(i);
      current = new StoreLight(cam, aux.v1, aux.v2, aux.v3, aux.angle, aux.concentration, aux.type);
    }
  }
}

void showLights(){
  for (int i = 0; i < cams.size(); i++){
    StoreLight current;
    if (currentCam != i){
      current = cams.get(i);
    }else{
      StoreLight aux = cams.get(i);
      current = new StoreLight(cam, aux.v1, aux.v2, aux.v3, aux.angle, aux.concentration, aux.type);
    }
    switch (current.type) {
      case StoreLight.CAM:
        break;
      case StoreLight.SPOTLIGHT:
        spotLight(current.v1, current.v2, current.v3,
          current.getPosition().x, current.getPosition().y, current.getPosition().z,
          current.getForward().x, current.getForward().y, current.getForward().z,
          current.angle, current.concentration);
        break;
      case StoreLight.POINTLIGHT:
        pointLight(current.v1, current.v2, current.v3,
          current.getPosition().x, current.getPosition().y, current.getPosition().z);
        break;
      case StoreLight.DIRECTIONALLIGHT:
        directionalLight(current.v1, current.v2, current.v3,
          current.getForward().x, current.getForward().y, current.getForward().z);
        break;
      case StoreLight.AMBIENTLIGHT:
        ambientLight(current.v1, current.v2, current.v3,
          current.getPosition().x, current.getPosition().y, current.getPosition().z);
        break;
    }
  }
}

void keyReleased(){
  keyCheck();
  changeStep();
}

void changeStep(){
  if (key == 'm' || key == 'M'){
    if (step == 1){
      step = 10;
    }else{
      step = 1;
    }
  }
}

void changeCamValues(){
    StoreLight current = cams.get(currentCam);
    switch(key){
      case CODED:
        break;
      case 'u': //r up
      case 'U':
        current.setV1(checkIfInRangeRGB(current.getV1()+step));
        break;
      case 'j': //r down
      case 'J':
        current.setV1(checkIfInRangeRGB(current.getV1()-step));
        break;
      case 'i': //g up
      case 'I':
        current.setV2(checkIfInRangeRGB(current.getV2()+step));
        break;
      case 'k': //g down
      case 'K':
        current.setV2(checkIfInRangeRGB(current.getV2()-step));
        break;
      case 'o': //b up
      case 'O':
        current.setV3(checkIfInRangeRGB(current.getV3()+step));
        break;
      case 'l': //b down
      case 'L':
        current.setV3(checkIfInRangeRGB(current.getV3()-step));
        break;
      case 'y': //angle up
      case 'Y':
        current.setAngle(checkIfInRange(current.getAngle()+step,0,360));
        break;
      case 'h': //angle down
      case 'H':
        current.setAngle(checkIfInRange(current.getAngle()-step,0,360));
        break;
      case 't': //angle up
      case 'T':
        current.setConcentration(checkIfInRange(current.getConcentration()+step,0,1000));
        break;
      case 'g': //angle down
      case 'G':
        current.setConcentration(checkIfInRange(current.getConcentration()-step,0,1000));
        break;
  }
}


void keyCheck(){
  switch(key){
    case CODED:
      break;
    case ' ':
      nextCam();
      break;
    case 'r':
    case 'R':
      if (cams.size() < 8){
        cams.add(new StoreLight(cam,150,150,150,50,0,StoreLight.SPOTLIGHT));
      }
      break;
    case 'f':
    case 'F':
      if (cams.size() != 1){
        cams.remove(currentCam);
        if (currentCam != 0){
          currentCam--;
        }
        cams.get(currentCam).getCam().writeCam(cam);
      }
      break;
    case 'z':
    case 'Z':
      cams.get(currentCam).setType(StoreLight.CAM);
      break;
    case 'x':
    case 'X':
      cams.get(currentCam).setType(StoreLight.SPOTLIGHT);
      break;
    case 'c':
    case 'C':
      cams.get(currentCam).setType(StoreLight.POINTLIGHT);
      break;
    case 'v':
    case 'V':
      cams.get(currentCam).setType(StoreLight.DIRECTIONALLIGHT);
      break;
    case 'b':
    case 'B':
      cams.get(currentCam).setType(StoreLight.AMBIENTLIGHT);
      break;
    case 'n':
    case 'N':
      hudOn = !hudOn;
      break;
  }
}

float checkIfInRangeRGB(float check){
  return checkIfInRange(check, 0, 255);
}

float checkIfInRange(float check, float bottomLimit, float upperLimit){
  if (check < bottomLimit){
    return bottomLimit;
  }else if (upperLimit < check){
    return upperLimit;
  }else{
    return check;
  }
}

void nextCam(){
  cams.get(currentCam).getCam().storeCam(cam);
  currentCam++;
  if (cams.size() <= currentCam){
    currentCam = 0;
  }
  cams.get(currentCam).getCam().writeCam(cam);
}


void scene(){
  PShape floor;
  floor = createShape(BOX,new float[]{4000,1,4000});
  floor.setTexture(loadImage(imgPath + "floor.jpg"));
  endShape();
  floor.translate(0,100,0);
  shapes.add(floor);

  PShape gordon;
  gordon = loadShape(objPath + "gordon/gordon.obj");
  endShape();
  gordon.setStroke(255);
  gordon.translate(0,50,20);
  gordon.rotateX(radians(90));
  gordon.rotateY(radians(90));
  gordon.scale(10);
  gordon.translate(900,-500,0);
  shapes.add(gordon);

  PShape box;
  box = createShape(BOX, new float[]{100,100,100});
  shapes.add(box);

  PShape sphere;
  sphere = createShape(SPHERE, 40);
  sphere.setStroke(255);
  sphere.translate(-300,-100,0);
  shapes.add(sphere);

  PShape sphere2;
  sphere2 = createShape(SPHERE, 40);
  sphere2.setStroke(255);
  sphere2.scale(3,0.9,1.5);
  shapes.add(sphere2);

}

void showShapes(){
  textureWrap(REPEAT);
  int i = 0;
  for (PShape shape : shapes){
    if (i == 2){
      pushMatrix();
      shape.rotateY(radians(1));
      translate(-300,0,0);
      shape(shape);
      popMatrix();
    }else if (i == 4){
      pushMatrix();
      shape.rotateY(radians(359));
      translate(-300,-300,0);
      shape(shape);
      popMatrix();
    }else{
      shape(shape);
    }
    i++;
  }
}

void printHUDText(String[] text){
  camera();
  hint(DISABLE_DEPTH_TEST);
  noLights();
  textMode(MODEL);
  textSize(20);
  fill(255);
  for (int i = 0; i < text.length; i++){
    text(text[i], 10, 25*(i+1));
  }
  hint(ENABLE_DEPTH_TEST);
}



String typeToString(int type){
  switch (type) {
    case StoreLight.CAM:
      return "CAM";
    case StoreLight.SPOTLIGHT:
      return "SPOTLIGHT";
    case StoreLight.POINTLIGHT:
      return "POINTLIGHT";
    case StoreLight.DIRECTIONALLIGHT:
      return "DIRECTIONALLIGHT";
    case StoreLight.AMBIENTLIGHT:
      return "AMBIENTLIGHT";
  }
  return "TYPE_ERROR";
}
