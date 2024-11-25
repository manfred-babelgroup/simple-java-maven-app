@echo off
echo The following Maven command installs your Maven-built Java application
echo into the local Maven repository, which will ultimately be stored in
echo Jenkins's local Maven repository (and the "maven-repository" Docker data
echo volume).

REM Habilitar el modo detallado para mostrar los comandos ejecutados
echo Running Maven install...
mvn jar:jar install:install help:evaluate -Dexpression=project.name

echo The following complex command extracts the value of the <name/> element
echo within <project/> of your Java/Maven project''s "pom.xml" file.

REM Extraer el nombre del proyecto desde Maven
for /f "tokens=*" %%i in ('mvn help:evaluate -Dexpression=project.name ^| findstr /r "^[^[]*"') do set NAME=%%i

echo The following complex command behaves similarly to the previous one but
echo extracts the value of the <version/> element within <project/> instead.

REM Extraer la versión del proyecto desde Maven
for /f "tokens=*" %%i in ('mvn help:evaluate -Dexpression=project.version ^| findstr /r "^[^[]*"') do set VERSION=%%i

echo The following command runs and outputs the execution of your Java
echo application (which Jenkins built using Maven) to the Jenkins UI.

REM Ejecutar la aplicación Java
java -jar target\%NAME%-%VERSION%.jar
