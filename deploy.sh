docker build -t abhayj/fibo-client:latest -t abhayj/fibo-client:$SHA -f ./client/Dockerfile ./client
docker build -t abhayj/fibo-server:latest -t abhayj/fibo-server:$SHA -f ./server/Dockerfile ./server
docker build -t abhayj/fibo-worker:latest -t abhayj/fibo-worker:$SHA -f ./worker/Dockerfile ./worker

docker push abhayj/fibo-client:latest
docker push abhayj/fibo-server:latest
docker push abhayj/fibo-worker:latest

docker push abhayj/fibo-client:$SHA
docker push abhayj/fibo-server:$SHA
docker push abhayj/fibo-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=abhayj/fibo-server:$SHA
kubectl set image deployments/client-deployment client=abhayj/fibo-client:$SHA
kubectl set image deployments/worker-deployment worker=abhayj/fibo-worker:$SHA