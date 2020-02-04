#version 330 core
layout (location = 0) in vec3 in_position; //In es atributo de entrada
layout (location = 2) in vec2 in_uv; //El mismo numero que se indexa en el shader
layout (location = 3) in vec3 in_normal;

out vec2 our_uv; //Esto es lo que se pasa al shader de fragmento
out vec3 our_normal;
out vec3 fragPos;

uniform mat4 projection;//Esta es del clip space
uniform mat4 view; // Es la cámara, cómo se ve desde tu perspectiva
uniform mat4 model; // Sirve para ubicar en un espacio más grande el modelo
//Local, mundo, vista, clip space(espacio de recorte), screen space (de 3D a 2D, qué parte de la pantalla se ocupa para el render glViewPort(0,0,w,h))
uniform float offsetX;
uniform vec2 scaleUV;

//uniform son variables globales dentro de openGL, pueden verlo tanto el vertex como el fragment

void main()
{
	
	gl_Position = projection * view * model * vec4(in_position, 1.0); //Debe de esperarla openGL, no es necesario declarar
	our_uv = in_uv; //Para desplazar la textura
	our_uv.x = our_uv.x + offsetX; //El offset mueve la textura
	if(scaleUV.x != 0 && scaleUV.y != 0)
		our_uv *= scaleUV;
	fragPos = vec3(model * vec4(in_position, 1.0)); //Calcula la posición del fragmento
	our_normal = mat3(transpose(inverse(model))) * in_normal; //Se aplica una transformación de la normal
}
