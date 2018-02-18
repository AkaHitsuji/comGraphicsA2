// The uniform variable is set up in the javascript code and the same for all vertices
uniform vec3 lightPosition;
uniform int laserID;
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
mat4 rotateX(float angle) {
  float s = sin(angle);
  float c = cos(angle);
  return mat4(
    vec4(1.0,0.0,0.0,0.0),
    vec4(0.0,c,s,0.0),
    vec4(0.0,-s,c,0.0),
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

void main() {
  vec3 leftEyePosition = vec3(-0.15,2.4,-0.6);
  vec3 rightEyePosition = vec3(0.15,2.4,-0.6);

  float leftDist = distance(leftEyePosition,lightPosition);

  if(laserID==0) {
    gl_Position = projectionMatrix * modelViewMatrix * translate(0.15,2.4,-0.6) * lookAt(rightEyePosition) * rotateX(-1.57) * scale(1.0,leftDist/2.0,1.0) * vec4(position, 1.0);
  }
  else {
    gl_Position = projectionMatrix * modelViewMatrix * translate(-0.15,2.4,-0.6) * lookAt(leftEyePosition) * rotateX(-1.57) * scale(1.0,leftDist/2.0,1.0) * vec4(position, 1.0);
  }
}
