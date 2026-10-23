-- 001: create the bookmarks table
CREATE TABLE bookmarks (
    id        BIGSERIAL PRIMARY KEY,
    url       TEXT NOT NULL,
    title     TEXT NOT NULL,
    notes     TEXT,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),

    CONSTRAINT url_length CHECK(char_length(url)<=2000),
    CONSTRAINT url_scheme CHECK(url ~ '^https?://'),
    CONSTRAINT title_length CHECK (char_length(title) <= 200),
    CONSTRAINT notes_length CHECK (notes IS NULL OR char_length(notes) <= 500),
    CONSTRAINT url_unique   UNIQUE (url)
);

-- the list endpoint shows newest first
CREATE INDEX bookmarks_created_at_idx ON bookmarks (created_at DESC, id DESC);