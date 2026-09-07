CREATE TABLE IF NOT EXISTS accounts (
 id TEXT PRIMARY KEY,
 name TEXT NOT NULL,
 pinterest_user_id TEXT,
 pinterest_username TEXT,
 status TEXT NOT NULL DEFAULT 'disconnected',
 access_token_enc TEXT,
 refresh_token_enc TEXT,
 access_token_expires_at INTEGER,
 refresh_token_expires_at INTEGER,
 scopes TEXT,
 connected_at INTEGER,
 updated_at INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS oauth_states (state TEXT PRIMARY KEY, account_id TEXT NOT NULL, created_at INTEGER NOT NULL, FOREIGN KEY(account_id) REFERENCES accounts(id));
CREATE TABLE IF NOT EXISTS imports (id TEXT PRIMARY KEY, filename TEXT NOT NULL, account_ids TEXT NOT NULL, row_count INTEGER NOT NULL, approved_count INTEGER NOT NULL DEFAULT 0, created_at INTEGER NOT NULL);
CREATE TABLE IF NOT EXISTS pins (
 id TEXT PRIMARY KEY, import_id TEXT NOT NULL, account_id TEXT NOT NULL, publish_at INTEGER NOT NULL,
 title TEXT NOT NULL, description TEXT, image_url TEXT NOT NULL, destination_url TEXT,
 board_id TEXT, board_name TEXT, section_id TEXT, section_name TEXT, alt_text TEXT,
 status TEXT NOT NULL DEFAULT 'imported', pinterest_pin_id TEXT, last_error TEXT, attempts INTEGER NOT NULL DEFAULT 0,
 created_at INTEGER NOT NULL, updated_at INTEGER NOT NULL, FOREIGN KEY(import_id) REFERENCES imports(id), FOREIGN KEY(account_id) REFERENCES accounts(id)
);
CREATE INDEX IF NOT EXISTS idx_pins_due ON pins(status,publish_at);
