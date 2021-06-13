docker build -t andrecamilosr/multi-client:latest -t andrecamilosr/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t andrecamilosr/multi-server:latest -t andrecamilosr/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t andrecamilosr/multi-worker:latest -t andrecamilosr/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push andrecamilosr/multi-client:latest
docker push andrecamilosr/multi-server:latest
docker push andrecamilosr/multi-worker:latest

docker push andrecamilosr/multi-client:$SHA
docker push andrecamilosr/multi-server:$SHA
docker push andrecamilosr/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=andrecamilosr/multi-server:$SHA
kubectl set image deployments/client-deployment client=andrecamilosr/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=andrecamilosr/multi-worker:$SHA