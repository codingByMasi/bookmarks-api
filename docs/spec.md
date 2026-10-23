# Bookmarks API: Spec

## 1. Purpose

A small web service that saves web links (bookmarks). A client can add, list, read, change and delete bookmarks over HTTP. When a bookmark is added without a title, the service fetches the page title itself.

## 2. Data

A bookmark has:

- id:number,set by the server
- url:required, must start with http:// or https:// ,max 2000 characters 
- title: optional,fetched from page if empty,max 200 characters
- notes: optional,max 500 characters
- created_at : set by the server
- the same url cannot be saved twice

## 3. Endpoints
- GET /health -> 200
- POST /bookmarks -> 201
- GET /bookmarks -> 200
- GET /bookmarks/{id} -> 200
- PATCH /bookmarks/{id} -> 200
- DELETE /bookmarks/{id} -> 204

## 4. Title fetch rules
- Only when the client sends no title, the service fetches the page title.
- If the client sends a title, no fetch happens.
- The fetch times out after 5 seconds.
- If the page cannot be reached or returns an error, nothing is saved
  and the client gets 502 upstream_error.
- If the fetch times out, nothing is saved and the client gets
  504 upstream_timeout.
- If the page loads but has no title, save the bookmark with the url as its title.

## 5. Errors (one shape: {"error": {"code": "...", "message": "..."}})
- id not found -> 404 not_found
- bad input -> 422 validation_error
- duplicate url -> 409 duplicate_url
- page fetch broken -> 502 upstream_error
- page fetch slow -> 504 upstream_timeout

## 6. Non-goals
- no users, no tags, no search, no web page
 