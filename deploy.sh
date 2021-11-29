docker build -t chriskr7/multi-client:lastest -t chriskr7/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t chriskr7/multi-server:lastest -t chriskr7/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t chriskr7/multi-worker:lastest -t chriskr7/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push chriskr7/multi-client:lastest
docker push chriskr7/multi-server:lastest
docker push chriskr7/multi-worker:lastest
docker push chriskr7/multi-client:$SHA
docker push chriskr7/multi-server:$SHA
docker push chriskr7/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=chriskr7/multi-client:$SHA
kubectl set image deployments/server-deployment server=chriskr7/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=chriskr7/multi-worker:$SHA