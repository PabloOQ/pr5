import queasycam.*;

class StoreCam{

  float speed;
  PVector velocity;
  float sensitivity;
  PVector position;
  float pan;
  float tilt;
  float friction;
  PVector forward;
  PVector right;

  StoreCam(QueasyCam cam){
    //StoreCam(cam.speed, cam.velocity.copy(), cam.sensitivity, cam.position.copy(), cam.pan, cam.tilt, cam.friction);
    this.speed        = cam.speed;
    this.velocity     = cam.velocity.copy();
    this.sensitivity  = cam.sensitivity;
    this.position     = cam.position.copy();
    this.pan          = cam.pan;
    this.tilt         = cam.tilt;
    this.friction     = cam.friction;
    this.forward      = cam.getForward().copy();
    this.right        = cam.getRight().copy();
  }

  void writeCam(QueasyCam cam){
    cam.speed       = speed;
    cam.velocity    = velocity.copy();
    cam.sensitivity = sensitivity;
    cam.position    = position.copy();
    cam.pan         = pan;
    cam.tilt        = tilt;
    cam.friction    = friction;
  }

  void storeCam(QueasyCam cam){
    speed       = cam.speed;
    velocity    = cam.velocity.copy();
    sensitivity = cam.sensitivity;
    position    = cam.position.copy();
    pan         = cam.pan;
    tilt        = cam.tilt;
    friction    = cam.friction;
  }

  PVector getPosition(){
    return position.copy();
  }

  PVector getForward(){
    return forward;
  }

  PVector getRight(){
    return right;
  }
}