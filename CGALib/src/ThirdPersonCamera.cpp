#include "Headers/ThirdPersonCamera.h"

ThirdPersonCamera::ThirdPersonCamera(){
    pitch = glm::radians(20.0f); //Para que tenga inicialización
    yaw = 0.0f;
    angleAroundTarget = 0.0f;
    angleTarget = 0.0;
    distanceFromTarget = 1.0f;
    sensitivity = SENSITIVTY;
    worldUp = glm::vec3(0.0, 1.0, 0.0);
    updateCamera();
}

void ThirdPersonCamera::mouseMoveCamera(float xoffset, float yoffset, float dt){
    // Camera controls
    float cameraSpeed = sensitivity * dt; //Eventos del mouse

    // Calculate pitch
    pitch += yoffset * cameraSpeed;
    // Calculate Angle Arround
    angleAroundTarget -= xoffset * cameraSpeed;
    if(pitch > M_PI / 2) //Condiciones de que no pase éste rango
        pitch = M_PI / 2 - 0.01;
    if(pitch < -M_PI / 2)
        pitch = -M_PI / 2 + 0.01;
    updateCamera();
}

void ThirdPersonCamera::scrollMoveCamera(float soffset, float dt){
    // Camera controls
    float cameraSpeed = sensitivity * dt; //Cambia a distancia de la camara al punto
    // Calculate zoom
    float zoomLevel = soffset * cameraSpeed;
    distanceFromTarget -= zoomLevel;
    updateCamera();
}

void ThirdPersonCamera::updateCamera(){ //Calcula las ecuaciones 
    //Calculate Horizontal distance
    //setAngle();
    float horizontalDistance = distanceFromTarget * cos(pitch);
    //Calculate Vertical distance
    float verticalDistance = distanceFromTarget * sin(pitch);

    //Calculate camera position
    float theta = angleTarget + angleAroundTarget; //ANgulo que hay del punto objetivo mas el angulo alrededor
    float offsetx = horizontalDistance * sin(theta); //Los desplazamientos en los ejes
    float offsetz = horizontalDistance * cos(theta);
    position.x = cameraTarget.x - offsetx; //
    position.z = cameraTarget.z - offsetz;
    position.y = cameraTarget.y + verticalDistance;

    yaw = angleTarget - (180 + angleAroundTarget);

    if (distanceFromTarget < 0) //<0 se volta el vector por si se hace negativo
    	front = glm::normalize(position - cameraTarget);
    else
    	front = glm::normalize(cameraTarget - position);

    this->right = glm::normalize(glm::cross(this->front, this->worldUp)); //Sistema coordenado
    this->up = glm::normalize(glm::cross(this->right, this->front));
}


