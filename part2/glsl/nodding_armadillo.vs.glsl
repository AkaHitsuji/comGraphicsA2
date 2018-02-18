// Shared variable passed to the fragment shader
varying vec3 color;
uniform float noddingAngle;
uniform mat4 translationMatrix;
uniform mat4 inverseTranslationMatrix;

//For part 2
uniform float leftArmAngle;
uniform float rightArmAngle;
uniform mat4 left_tMat;
uniform mat4 left_invMat;
uniform mat4 right_tMat;
uniform mat4 right_invMat;

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

//for Part 2
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

void main() {
	// No lightbulb, but we still want to see the armadillo!
	vec3 l = vec3(0.0, 0.0, -1.0);
	color = vec3(1.0) * dot(l, normal);

	// Identifying the head
	if (position.z < -0.33 && abs(position.x) < 0.46) {
		//color = vec3(1.0, 0.0, 1.0);
		gl_Position = projectionMatrix * modelViewMatrix * inverseTranslationMatrix * rotateX(noddingAngle) * translationMatrix * vec4(position,1.0);
	}
	//for Part 2
	else if (position.x>0.5 && position.y>1.5) {
		//color = vec3(0.0, 1.0, 0.0);
		gl_Position = projectionMatrix * modelViewMatrix * left_invMat * rotateY(leftArmAngle) * left_tMat *  vec4(position, 1.0);
	}
	else if (position.x<-0.55 && position.y>1.5) {
		//color = vec3(1.0,0.0,0.0);
		gl_Position = projectionMatrix * modelViewMatrix * right_invMat * rotateY(rightArmAngle) * right_tMat * vec4(position, 1.0);
	}
	else {
		gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
	}
}
