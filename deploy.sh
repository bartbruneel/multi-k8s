docker build -t bartbruneel/multi-client:latest -t bartbruneel/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bartbruneel/multi-server:latest -t bartbruneel/multi-server:$SHA -f ./server/Dockerfile ./server 
docker build -t bartbruneel/multi-worker:latest -t bartbruneel/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push bartbruneel/multi-client:latest
docker push bartbruneel/multi-server:latest
docker push bartbruneel/multi-worker:latest

docker push bartbruneel/multi-client:$SHA
docker push bartbruneel/multi-server:$SHA
docker push bartbruneel/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bartbruneel/multi-server:$SHA
kubectl set image deployments/client-deployment client=bartbruneel/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bartbruneel/multi-worker:$SHA