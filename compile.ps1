$root = $PSScriptRoot
New-Item -ItemType Directory -Path "C:\temp_build" -Force | Out-Null
$classesPath = "C:/temp_build/classes"
New-Item -ItemType Directory -Path $classesPath -Force | Out-Null

$libPath = "$root/target/HTTMDT-1.0-SNAPSHOT/WEB-INF/lib"
$tomcatLib = "D:/apache-tomcat-10.1.53/lib"

# Copy source java files to C:\temp_build\src
$tempSrc = "C:/temp_build/src"
if (Test-Path $tempSrc) { Remove-Item $tempSrc -Recurse -Force }
Copy-Item -Path "$root\src\main\java\*" -Destination $tempSrc -Recurse -Force

# Copy jars to C:\temp_build\lib
$tempLib = "C:/temp_build/lib"
if (Test-Path $tempLib) { Remove-Item $tempLib -Recurse -Force }
New-Item -ItemType Directory -Path $tempLib -Force | Out-Null
Copy-Item -Path "$root\target\HTTMDT-1.0-SNAPSHOT\WEB-INF\lib\*.jar" -Destination $tempLib -Force
Copy-Item -Path "$tomcatLib\*.jar" -Destination $tempLib -Force

$cp = (Get-ChildItem -Path $tempLib -Filter "*.jar" | ForEach-Object { $_.FullName }) -join ";"
$javaFiles = Get-ChildItem -Path $tempSrc -Recurse -Filter "*.java" | ForEach-Object { $_.FullName }
[System.IO.File]::WriteAllLines("C:\temp_build\sources.txt", $javaFiles)

& "C:\Program Files\Apache NetBeans\jdk\bin\javac.exe" -encoding UTF-8 -cp "$cp;$classesPath" -d "$classesPath" "@C:\temp_build\sources.txt"
Write-Output "Compile exit code: $LASTEXITCODE"

if ($LASTEXITCODE -eq 0) {
    # Copy compiled classes back to target
    $destClasses = "$root\target\HTTMDT-1.0-SNAPSHOT\WEB-INF\classes"
    Copy-Item -Path "C:\temp_build\classes\*" -Destination $destClasses -Recurse -Force
    Write-Output "Classes successfully copied to target/HTTMDT-1.0-SNAPSHOT/WEB-INF/classes"

    # Copy updated web files (JSPs, JS, CSS)
    $srcWeb = "$root\src\main\webapp"
    $destWeb = "$root\target\HTTMDT-1.0-SNAPSHOT"
    Copy-Item -Path "$srcWeb\index.jsp" -Destination $destWeb -Force
    Copy-Item -Path "$srcWeb\search.jsp" -Destination $destWeb -Force
    Copy-Item -Path "$srcWeb\admin.jsp" -Destination $destWeb -Force
    Copy-Item -Path "$srcWeb\customer.jsp" -Destination $destWeb -Force
    Copy-Item -Path "$srcWeb\guide.jsp" -Destination $destWeb -Force
    Copy-Item -Path "$srcWeb\login.jsp" -Destination $destWeb -Force
    Copy-Item -Path "$srcWeb\js\store.js" -Destination "$destWeb\js\store.js" -Force
    Copy-Item -Path "$srcWeb\css\style.css" -Destination "$destWeb\css\style.css" -Force
    Write-Output "JSPs, JS, and CSS successfully copied to target deployment"
}
