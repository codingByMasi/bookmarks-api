# CLAUDE.md - Bookmarks API

Read this first.The spec is in docs/spec.md and is the source of truth.

## what this is
A REST service that saves bookmarks.No AI inside it.No users,no login.

## Stack
Python 3.11+,FastAPI,Postgres,psycopg(plain SQL,no ORM),pytest.

## Folder layout 
- app/  the service code
- migrations/ numbered SQL files (001_....,002_...)
- tests/ pytest tests
- docs/ spec.md, ai-notes.md

## Rules
- Follow docs/spec.md exactly.If the spec is wrong, change the spec first.
- Every error uses the one JSON shape from the spec. No other shape.
- Config comes from environment variables only (see .env.example). Never hardcode.
- Never commit secrets or a real .env file.
- Database changes only through a new numbered file in migrations/. Never edit an old one.
- Storage is passed into endpoints (dependency injection), so tests can use a fake.
- The title fetch is async and has a timeout. 502 and 504 as in the spec.
- Every new endpoint or rule gets a test.

## Commands
- Install:  pip install -r requirements.txt
- Run:      uvicorn app.main:app --reload
- Test:     pytest