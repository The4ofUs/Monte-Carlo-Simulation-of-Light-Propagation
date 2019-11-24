#include <curand.h>
#include <curand_kernel.h>
#include <iostream>

#define NUMBER_OF_PHOTONS 1000
#define THREADS_PER_BLOCK 1024  
#define BOUNDARY_RADIUS 10.0  


/* ----------- Point ----------- */
class Point{

public:
    __device__ __host__ Point(float x, float y, float z){
        setCoordinates(x, y, z);
    }
    __device__ __host__ Point(){
        setCoordinates(0.f, 0.f, 0.f);
    }
    __device__ __host__ void setCoordinates(float x, float y, float z)
    {
        this->_x = x;
        this->_y = y;
        this->_z = z;
    }
    __device__ __host__ float x() const { return this->_x; }
    __device__ __host__ float y() const { return this->_y; }
    __device__ __host__ float z() const { return this->_z; }
    __device__ __host__ Point operator - (Point const &other) { 
        float result_x = this->_x - other.x();
        float result_y = this->_y - other.y();
        float result_z = this->_z - other.z();
        return Point(result_x, result_y, result_z); 
    }
    __device__ __host__ Point operator + (Point const &other) { 
        float result_x = this->_x + other.x();
        float result_y = this->_y + other.y();
        float result_z = this->_z + other.z();
        return Point(result_x, result_y, result_z); 
    }
    __device__ __host__ Point operator * (float const &other) { 
        float result_x = this->_x * other;
        float result_y = this->_y * other;
        float result_z = this->_z * other;
        return Point(result_x, result_y, result_z); 
    }
private:
    float _x;
    float _y;
    float _z;
};

/* ----------- RNG ----------- */
class RNG{
private:
    __device__ float generate( curandState* globalState, int i) {
        curandState localState = globalState[i];
        float random = curand_uniform( &localState );
        globalState[i] = localState;
        return random;
    }
public:
    __device__ float getRandomStep( curandState* globalState , int i) { 
        float step = 0.f;       // Intialize for step value
        step = generate (globalState, i);
        return step;
    } 
    __device__ Point getRandomPoint( curandState* globalState , int i){
        float u = generate (globalState , i);
        float v = generate (globalState, i);
        float theta = 2 * M_PI * u;
        float phi = acos(1 - 2 * v);
        float x = sin(phi) * cos(theta);
        float y = sin(phi) * sin(theta);
        float z = cos(phi);
        return Point(x,y,z);
    }
};

/* ----------- Ray ----------- */
class Ray{
private:
    Point _prevPos;
    Point _currentPos;
    Point _direction;
    float _step;
    __device__ __host__ void updateRayState(Point direction, float step){
        this->_prevPos = this->_currentPos;
        this->_direction = direction;
        this->_step = step;
    }
public:
    __device__ __host__ Ray(Point startingPoint, Point direction){
        this->_currentPos.setCoordinates(startingPoint.x(), startingPoint.y(), startingPoint.z());
        this->_direction.setCoordinates(direction.x(), direction.y(), direction.z());
    }
    __device__ __host__ void setDirection(Point direction) { this->_direction.setCoordinates(direction.x(), direction.y(), direction.z()); }
    __device__ __host__ void setStep(float step) { this->_step = step; }
    __device__ __host__ Point getCurrentPos() const { return this->_currentPos; }
    __device__ __host__ Point getDirection() const { return this->_direction; }
    __device__ __host__ Point getPrevPos() const { return this->_prevPos; }
    __device__ __host__ float getStep() const { return this->_step; }
    __device__ __host__ void move(Point direction, float step)
    {
        updateRayState(direction, step);
        this->_currentPos = this->_currentPos + (direction * step);
    }
};

/* ----------- Boundary ----------- */
class Boundary{
private:
    float _radius;
    Point _center;
    __device__ __host__ float dot(Point point1, Point point2){return point1.x()*point2.x() + point1.y()*point2.y() + point1.z()*point2.z();}
public:
    __device__ __host__ Boundary(float r, Point c){
        _radius = r;
        _center = c;
    }
    __device__ __host__ void setRadius(float r){_radius = r;}
    __device__ __host__ float getRadius() const {return _radius;}
    __device__ __host__ void setCenter(Point c){_center = c;}
    __device__ __host__ Point getCenter() const {return _center;}
    __device__ __host__ bool isHit(Ray ray){
        float absDistance = (float) sqrtf((float) powf(ray.getCurrentPos().x(),2) + (float) powf(ray.getCurrentPos().y(),2) + (float) powf(ray.getCurrentPos().z(),2));
        if(absDistance >= _radius){ return true;} else { return false;}
    }
    __device__ __host__ Point getIntersectionPoint(Ray ray){
            Point A = ray.getPrevPos();
            Point B = ray.getDirection();
            Point S = A + _center;
            Point A_C = A - _center;
            float a = dot(B, B);
            float b = 2.0 * dot(B, A_C);
            float c = dot(A_C, A_C) - _radius*_radius;
            float discriminant = b*b - 4*a*c;
            float t1 = (-b + sqrtf(discriminant)) / (2.0*a);
            float t2 = (-b - sqrtf(discriminant)) / (2.0*a);
            float t;
            if(t1 < 0){ t = t2;} else { t = t1;}
            return (A+B*t);
    }
};

/* ----------- RandomWalk ----------- */
__device__ Point randomWalk(curandState_t *states, int idx, Boundary boundary, RNG rng)
{
    Ray ray = Ray(Point(), Point());
    while (!boundary.isHit(ray)){ 
        ray.move(rng.getRandomPoint(states, idx), rng.getRandomStep(states, idx));
    }
    return boundary.getIntersectionPoint(ray);
}

/* ----------- streamOut ----------- */
void streamOut(Point* _cpuPoints)  
{
    FILE *output;
    output = fopen("output.csv", "w");
    for (int i = 0; i < NUMBER_OF_PHOTONS; i++)
    {
        fprintf(output, "%f,%f,%f\n", _cpuPoints[i].x(), _cpuPoints[i].y(), _cpuPoints[i].z());
    }
}

/* ----------- FinalPosition Kernel ----------- */
__global__ void finalPosition(unsigned int seed, curandState_t* states, Point* _gpuPoints, Boundary boundary, RNG rng, int n) {
    int idx = blockIdx.x*blockDim.x+threadIdx.x;
    if(idx < n){
    curand_init(seed, idx, 0, &states[idx]);
    Point finalPos = Point();
    finalPos = randomWalk(states, idx, boundary, rng);
    _gpuPoints[idx] = finalPos;
    }
}

/* ----------- Main ----------- */
int main() {
    int nBlocks = NUMBER_OF_PHOTONS/THREADS_PER_BLOCK + 1;
    curandState_t* states;
    cudaMalloc((void**) &states, NUMBER_OF_PHOTONS * sizeof(curandState_t));
    // Allocate host memory for final positions
    Point * _cpuPoints= (Point*)malloc(sizeof(Point) * NUMBER_OF_PHOTONS);
    // Allocate device  memory for final positions
    Point* _gpuPoints = nullptr;
    cudaMalloc((void**) &_gpuPoints, NUMBER_OF_PHOTONS * sizeof(Point));
    // Initialize the Boundary and the RandomNumberGenerator
    RNG rng;
    Boundary boundary = Boundary(BOUNDARY_RADIUS, Point());
    // Kernel Call
    finalPosition<<<nBlocks,THREADS_PER_BLOCK>>>(time(0), states , _gpuPoints, boundary, rng, NUMBER_OF_PHOTONS);
    // Copy device data to host memory to stream them out
    cudaMemcpy(_cpuPoints, _gpuPoints, NUMBER_OF_PHOTONS* sizeof(Point), cudaMemcpyDeviceToHost);
    streamOut (&_cpuPoints[0]);
    free(_cpuPoints);
    cudaFree(_gpuPoints);
    return 0;
}

