docker build -t lincwest/multi-client:latest -t lincwest/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lincwest/multi-server:latest -t lincwest/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lincwest/multi-worker:latest -t lincwest/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lincwest/multi-client:latest
docker push lincwest/multi-server:latest
docker push lincwest/multi-worker:latest

docker push lincwest/multi-client:$SHA
docker push lincwest/multi-server:$SHA
docker push lincwest/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lincwest/multi-server:$SHA
kubectl set image deployments/client-deployment client=lincwest/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=lincwest/multi-worker:$SHA