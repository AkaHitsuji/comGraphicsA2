// Shared variable passed to the fragment shader
varying vec3 color;
uniform float noddingAngle;
uniform mat4 translationMatrix;
uniform mat4 inverseTranslationMatrix;

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

void main() {
	// No lightbulb, but we still want to see the armadillo!
	vec3 l = vec3(0.0, 0.0, -1.0);
	color = vec3(1.0) * dot(l, normal);

	// Identifying the head
	if (position.z < -0.33 && abs(position.x) < 0.46) {
		//color = vec3(1.0, 0.0, 1.0);
		gl_Position = projectionMatrix * modelViewMatrix * inverseTranslationMatrix * rotateX(noddingAngle) * translationMatrix * vec4(position,1.0);
	}
	else {
		gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
	}
}
