docker build -t gavinongzk/multi-client:latest -t gavinongzk/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gavinongzk/multi-server:latest -t gavinongzk/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gavinongzk/multi-worker:latest -t gavinongzk/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push gavinongzk/multi-client:latest
docker push gavinongzk/multi-server:latest
docker push gavinongzk/multi-worker:latest
docker push gavinongzk/multi-client:$SHA
docker push gavinongzk/multi-server:$SHA
docker push gavinongzk/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=gavinongzk/multi-server:$SHA
kubectl set image deployments/client-deployment client=gavinongzk/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=gavinongzk/multi-worker:$SHA