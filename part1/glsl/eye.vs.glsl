// Shared variable passed to the fragment shader
varying vec3 color;
uniform vec3 lightPosition;
uniform int eyeID;
mat4 scale(float x,float y,float z) {
    return mat4(
        vec4(x,0.0,0.0,0.0),
        vec4(0.0,y,0.0,0.0),
        vec4(0.0,0.0,z,0.0),
        vec4(0.0,0.0,0.0,1.0)
    );
}
mat4 translate(float x,float y,float z) {
    return mat4(
        vec4(1.0,0.0,0.0,0.0),
        vec4(0.0,1.0,0.0,0.0),
        vec4(0.0,0.0,1.0,0.0),
        vec4(x,y,z,1.0)
    );
}
mat4 rotateY(float angle) {
  float s = sin(angle);
  float c = cos(angle);
  return mat4(
    vec4(c,0.0,-s,0.0),
    vec4(0.0,1.0,0.0,0.0),
    vec4(s,0.0,c,0.0),
    vec4(0.0,0.0,0.0,1.0)
  );
}
mat4 rotateZ(float angle) {
  float s = sin(angle);
  float c = cos(angle);
  return mat4(
    vec4(c,s,0.0,0.0),
    vec4(-s,c,0.0,0.0),
    vec4(0.0,0.0,1.0,0.0),
    vec4(0.0,0.0,0.0,1.0)
  );
}
mat4 lookAt(vec3 eyePosition) {
  vec3 upVector = vec3(0.0,1.0,0.0);
  vec3 zaxis = normalize(eyePosition - lightPosition);
  vec3 xaxis = normalize(cross(zaxis,upVector));
  vec3 yaxis = cross(zaxis, xaxis);
  return mat4(
    vec4(xaxis.x,yaxis.x,zaxis.x,0.0),
    vec4(xaxis.y,yaxis.y,zaxis.y,0.0),
    vec4(xaxis.z,yaxis.z,zaxis.z,0.0),
    vec4(0.0,0.0,0.0,1.0)
    );
}
#define MAX_EYE_DEPTH 0.15

void main() {
  // simple way to color the pupil where there is a concavity in the sphere
  // position is in local space, assuming radius 1
  float d = min(1.0 - length(position), MAX_EYE_DEPTH);
  color = mix(vec3(1.0), vec3(0.0), d * 1.0 / MAX_EYE_DEPTH);

  vec3 leftEyePosition = vec3(-0.15,2.4,-0.6);
  vec3 rightEyePosition = vec3(0.15,2.4,-0.6);

  //different position based on eyeID
  if(eyeID==0) {
    gl_Position = projectionMatrix * modelViewMatrix *
    translate(-0.15,2.4,-0.6) * lookAt(leftEyePosition) * rotateY(-1.57) * rotateZ(1.57) * scale(0.1,0.1,0.1) * vec4(position, 1.0);
  }
  else {
    gl_Position = projectionMatrix * modelViewMatrix *
    translate(0.15,2.4,-0.6) * lookAt(rightEyePosition) * rotateY(-1.57) * rotateZ(1.57) * scale(0.1,0.1,0.1) * vec4(position, 1.0);
  }
}
