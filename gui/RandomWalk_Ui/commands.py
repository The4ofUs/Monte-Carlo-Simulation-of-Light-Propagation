import os
import subprocess
import shutil

import analytics


def buildRW(application):
    application.logClear()
    openRWDirectory()
    if not os.path.isdir(os.getcwd() + "/build"):
        subprocess.run(['mkdir', 'build'])
        os.chdir(os.getcwd() + "/build")
        configcmd = subprocess.run(['cmake', '..'], stdout=subprocess.PIPE, encoding='utf-8', check=True,
                                   stderr=subprocess.PIPE)
        if configcmd.returncode != 0:
            application.logUpdates(configcmd.stderr)
        else:
            application.logUpdates(configcmd.stdout)

        buildcmd = subprocess.run(['make'], stdout=subprocess.PIPE, encoding='utf-8', check=True,
                                  stderr=subprocess.PIPE)
        if buildcmd.returncode != 0:
            application.logUpdates(buildcmd.stderr)
        else:
            application.logUpdates(buildcmd.stdout)


def runRW(application):
    openBuildDirectory()
    runcmd = subprocess.run(
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
         str(application.pLookAt[2])],
        stdout=subprocess.PIPE,
        encoding='utf-8', check=True, stderr=subprocess.PIPE)

    if runcmd.returncode != 0:
        application.logUpdates(runcmd.stderr)
    else:
        application.logUpdates(runcmd.stdout)
        analytics.produceAnalytics(application)


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
