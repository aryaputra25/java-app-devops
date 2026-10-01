#!/bin/bash
echo "======Start Deployment======"

echo "=== DEPLOY ==="
cp build/app.jar /var/lib/jenkins/server/app.jar

if [ $? -ne 0 ]; then
    echo "DEPLOY FAILED"
    exit 1
fi

echo "=== STOP OLD APPLICATION ==="

PID=$(pgrep -f "app.jar")

if [ -n "$PID" ]; then
    kill "$PID"
    sleep 2
fi

echo "=== START NEW APPLICATION ==="

cd /var/lib/jenkins/server

nohup java --add-modules jdk.httpserver -jar app.jar > app.log 2>&1 &

sleep 2

PID=$(pgrep -f "app.jar")

if [ -z "$PID" ]; then
    echo "APPLICATION FAILED TO START"
    echo "=== APPLICATION LOG ==="
    tail -n 50 app.log
    exit 1
fi

echo "Application started with PID: $PID"
echo "=== DEPLOYMENT SUCCESS ==="

