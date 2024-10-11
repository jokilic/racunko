#version 300 es
precision highp float;

uniform vec2 u_resolution;  // Screen resolution

// Function to generate random noise
float rand(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

// Output color
out vec4 fragColor;

void main() {
    // Normalize pixel coordinates
    vec2 uv = gl_FragCoord.xy / u_resolution;

    // Generate noise based on UV coordinates with a slight increase in size
    float noise = rand(uv);  // Slightly scale UV coordinates for larger particles

    // Define the threshold for visible grain
    float threshold = 0.925;  // Raise this value to reduce visibility of grain

    // Determine grain visibility
    if (noise > threshold) {
        // Visible grain spots (black color)
        fragColor = vec4(0.25, 0.25, 0.25, 1);  // Black grain with semi-transparency
    } else {
        // Fully transparent background
        fragColor = vec4(0.0, 0.0, 0.0, 0.0);  // Transparent background
    }
}
