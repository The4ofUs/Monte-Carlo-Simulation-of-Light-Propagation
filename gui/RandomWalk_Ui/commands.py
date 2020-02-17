import os
import shutil
import subprocess

import analytics


def buildRW(application):
    application.logClear()
    openRWDirectory()
    if not os.path.isdir(os.getcwd() + "/build"):
        openDirCmd = subprocess.call(['mkdir', 'build'])
        if openDirCmd == 0:
            os.chdir(os.getcwd() + "/build")
            configcmd = subprocess.call(['cmake', '..'])
            if configcmd == 0:
                buildcmd = subprocess.call(['make'], stderr=subprocess.STDOUT)
                if buildcmd == 0:
                    application.enableAll()
                else:
                    application.logUpdates("Couldn't execute 'make' command")
            else:
                application.logUpdates("Couldn't execute 'cmake ..' command")
        else:
            application.logUpdates("Couldn't create a build directory")


def runRW(application):
    openBuildDirectory()
    runcmd = subprocess.call(
        ['./RandomWalk', str(application.pNum), str(application.cThreadNum), str(application.dRadius),
         str(application.dPosition[0]),
         str(application.dPosition[1]),
         str(application.dPosition[2]), str(application.dLookAt[0]), str(application.dLookAt[1]),
         str(application.dLookAt[2]),
         str(application.tRadius),
         str(application.tAbsorpCoeff), str(application.tScatterCoeff), str(application.tCenter1[0]),
         str(application.tCenter1[1]),
         str(application.tCenter1[2]),
         str(application.tCenter2[0]), str(application.tCenter2[1]), str(application.tCenter2[2]),
         str(application.pPosition[0]),
         str(application.pPosition[1]),
         str(application.pPosition[2]), str(application.pLookAt[0]), str(application.pLookAt[1]),
         str(application.pLookAt[2])])

    if runcmd == 0:
        analytics.produceAnalytics(application)
    else:
        application.logUpdates("Couldn't Execute RandomWalk.o")


def openRWDirectory():
    if os.path.isdir(os.path.expanduser("~/3D-Random-Walk-CUDA")) and (
            os.getcwd() != os.path.expanduser("~/3D-Random-Walk-CUDA")):
        os.chdir(os.path.expanduser("~/3D-Random-Walk-CUDA"))


def openBuildDirectory():
    if os.path.isdir(os.path.expanduser("~/3D-Random-Walk-CUDA/build")) and (
            os.getcwd() != os.path.expanduser("~/3D-Random-Walk-CUDA/build")):
        os.chdir(os.path.expanduser("~/3D-Random-Walk-CUDA/build"))


def deleteBuildDir():
    if os.path.isdir(os.path.expanduser("~/3D-Random-Walk-CUDA/build")):
        if os.getcwd() == os.path.expanduser("~/3D-Random-Walk-CUDA"):
            shutil.rmtree('/build', ignore_errors=True)
        else:
            path = os.path.expanduser("~/3D-Random-Walk-CUDA")
            shutil.rmtree(path + '/build', ignore_errors=True)
