bool parseUserInput(int argc, char *argv[], int &nPhotons, int &nThreads, float &dRadius, Point &dPosition, Vector &dLookAt, float &tRadius, float &tAbsorpCoeff,
    float &tScatterCoeff, Point &tCenter1, Point &tCenter2, Point &pPosition, Vector &pLookAt){
        if (argc == 25) {
            nPhotons = std::atoi(argv[1]);
            nThreads = std::atoi(argv[2]);
            dRadius = std::atof(argv[3]);
            dPosition = Point(std::atof(argv[4]), std::atof(argv[5]), std::atof(argv[6]));
            dLookAt = Mathematics::calculateNormalizedVector(Vector(std::atof(argv[7]), std::atof(argv[8]), std::atof(argv[9])));
            tRadius = std::atof(argv[10]);
            tAbsorpCoeff = std::atof(argv[11]);
            tScatterCoeff = std::atof(argv[12]);
            tCenter1 = Point(std::atof(argv[13]), std::atof(argv[14]), std::atof(argv[15]));
            tCenter2 = Point(std::atof(argv[16]), std::atof(argv[17]), std::atof(argv[18]));
            pPosition = Point(std::atof(argv[19]), std::atof(argv[20]), std::atof(argv[21]));
            pLookAt = Mathematics::calculateNormalizedVector(Vector(std::atof(argv[22]), std::atof(argv[23]), std::atof(argv[24])));
            return true;
        } else {
            return false;
        }
    }
