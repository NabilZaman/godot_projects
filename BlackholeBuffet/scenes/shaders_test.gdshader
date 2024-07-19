shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

uniform sampler2D screenTexture: hint_screen_texture, filter_linear_mipmap;
uniform sampler2D distortionCurve;
uniform float strength: hint_range(-1.0, 1.0) = 0.5;

void fragment() {
	vec2 vecToCenter = vec2(0.5, 0.5) - UV;
	float distToCenter = length(vecToCenter);
	float curveVal = texture(distortionCurve, vec2(distToCenter)).x;
	vec2 diff = normalize(vecToCenter) * strength * curveVal;
	//vec4 warpedColor = texture(screenTexture, SCREEN_UV - diff);
	vec4 warpedColor = texture(screenTexture, SCREEN_UV + diff);
	//float avg = (warpedColor.r + warpedColor.g + warpedColor.b) / 3.0;
	COLOR = warpedColor;
	//if (avg < 0.1) {
		//COLOR = vec4(0.0, 0.0, 0.0, 1.0);
	//} else {
		//COLOR = warpedColor;
	//}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
