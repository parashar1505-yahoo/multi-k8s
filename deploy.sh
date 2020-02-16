docker build -t parashar1505/multi-client:latest -t parashar1505/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t parashar1505/multi-server:latest -t parashar1505/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t parashar1505/multi-worker:latest -t parashar1505/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push parashar1505/multi-client:latest
docker push parashar1505/multi-server:latest
docker push parashar1505/multi-worker:latest
docker push parashar1505/multi-client:$SHA
docker push parashar1505/multi-server:$SHA
docker push parashar1505/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=parashar1505/multi-server:$SHA
kubectl set image deployments/client-deployment client=parashar1505/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=parashar1505/multi-worker:$SHA