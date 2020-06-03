docker build -t chakatz/multi-client:latest -t chakatz/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t chakatz/multi-server:latest -t chakatz/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t chakatz/multi-worker:latest -t chakatz/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push chakatz/multi-client:latest
docker push chakatz/multi-server:latest
docker push chakatz/multi-worker:latest

docker push chakatz/multi-client:$SHA
docker push chakatz/multi-server:$SHA
docker push chakatz/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=chakatz/multi-client:$SHA
kubectl set image deployments/server-deployment client=chakatz/multi-server:$SHA
kubectl set image deployments/worker-deployment client=chakatz/multi-worker:$SHA