rd /S /Q dist
rd /S /Q build
c:\Python25\python.exe setup.py py2exe
copy mate_marote.sqlite dist\mate_marote.sqlite
xcopy mate_marote dist\mate_marote /S /Q /I
xcopy django dist\django /S /Q /I
