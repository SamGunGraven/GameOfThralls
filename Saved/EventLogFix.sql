/*
 *   This script copies the event log over to a separate table that maintains
	 an event log with timestamps. 

     This script is safe to run every restart, but only needs to be ran
     once.

     By Sam Gun Graven, 30th July 2018
 */

CREATE TABLE IF NOT EXISTS "got_admin_event_log" (
	"owner_id" bigint NOT NULL,
	"destroyed_by" TEXT,
	"object_type" INTEGER,
	"object_id" INTEGER,
	"time_destroyed" TIMESTAMP
);

DROP TRIGGER IF EXISTS "got_event_log_trigger";

CREATE TRIGGER "got_event_log_trigger" AFTER INSERT ON "destruction_history"
	FOR EACH ROW BEGIN
		INSERT INTO "got_admin_event_log" (owner_id, destroyed_by, object_type, object_id, time_destroyed) VALUES
			(new.owner_id, new.destroyed_by, new.object_type, new.object_id, CURRENT_TIMESTAMP);
		DELETE FROM "destruction_history" WHERE object_id = new.object_id;
	END;
