PRAGMA default_cache_size=700000;
PRAGMA cache_size=700000;
PRAGMA PAGE_SIZE = 4096;
PRAGMA auto_vacuum = 0;
VACUUM;
REINDEX;
ANALYZE;
pragma integrity_check;
.quit
