ALTER TABLE playlist
    ADD COLUMN history_page_index INTEGER NOT NULL DEFAULT 0;

UPDATE playlist
SET history_page_index = (
    -- Ceiling division: equivalent to CEIL(COUNT(*) / 50.0)
    SELECT (COUNT(*) + 49) / 50
    FROM playlist_episode
    WHERE playlist_episode.playlist_id = playlist.id
)
WHERE EXISTS (
    SELECT 1 FROM playlist_episode WHERE playlist_episode.playlist_id = playlist.id
);
