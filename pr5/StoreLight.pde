import queasycam.*;

class StoreLight{
  static final int CAM = 0;
  static final int SPOTLIGHT = 1;
  static final int POINTLIGHT = 2;
  static final int DIRECTIONALLIGHT = 3;
  static final int AMBIENTLIGHT = 4;

  StoreCam cam;
  float v1;
  float v2;
  float v3;
  float angle;
  float concentration;
  int type;

  StoreLight(QueasyCam cam, float v1, float v2, float v3, float angle, float concentration, int type){
    this.cam = new StoreCam(cam);
    this.v1 = v1;
    this.v2 = v2;
    this.v3 = v3;
    this.angle = angle;
    this.concentration = concentration;
    this.type = type;
  }

  StoreCam getCam(){
    return cam;
  }

  float getV1(){
    return v1;
  }

  float getV2(){
    return v2;
  }

  float getV3(){
    return v3;
  }

  float getAngle(){
    return angle;
  }

  float getConcentration(){
    return concentration;
  }

  PVector getPosition(){
    return cam.getPosition();
  }

  PVector getForward(){
    return cam.getForward();
  }

  float getNX(){
    return cam.getForward().x;
  }

  float getNY(){
    return cam.getForward().y;
  }

  float getNZ(){
    return cam.getForward().z;
  }

  PVector getRight(){
    return cam.getRight();
  }

  int getType(){
    return type;
  }

  void setV1(float v1){
    this.v1 = v1;
  }

  void setV2(float v2){
    this.v2 = v2;
  }

  void setV3(float v3){
    this.v3 = v3;
  }

  void setAngle(float angle){
    this.angle = angle;
  }

  void setConcentration(float concentration){
    this.concentration = concentration;
  }

  void setType(int type){
    this.type = type;
  }
}