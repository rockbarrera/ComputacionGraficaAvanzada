//Se utiliza la version 3.3 de openGL
#version 330 core

//Se genrera la variable uniforme de color
uniform vec4 ourColor; 
//Se genera la variable de salida para el color ¿hacia el monitor?
out vec4 color;

void main()
{
	//El color de entrada se va al color de salida
    color = ourColor;
}
