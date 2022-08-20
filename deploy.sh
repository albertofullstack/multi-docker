docker build -t albertombln/multi-client:latest -t albertombln/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t albertombln/multi-server:latest -t albertombln/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t albertombln/multi-worker:latest -t albertombln/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push albertombln/multi-client:latest
docker push albertombln/multi-server:latest
docker push albertombln/multi-worker:latest

docker push albertombln/multi-client:$SHA
docker push albertombln/multi-server:$SHA
docker push albertombln/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=albertombln/multi-server:$SHA
kubectl set image deployments/client-deployment client=albertombln/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=albertombln/multi-worker:$SHA
