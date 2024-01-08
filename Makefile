postgres:
	docker run --name postgres16 -p 5433:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:16-alpine3.18

createdb:
	docker exec -it postgres16 createdb --username=root --owner=root simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5433/simple_bank?sslmode=disable" -verbose up 
migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5433/simple_bank?sslmode=disable" -verbose down

dropdb:
	docker exec -it postgres16 dropdb --username=root --owner=root simple_bank

sqlc:
	sqlc generate

test:
	go test -v -cover -short ./...

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test

